def update_quality(awards):
    for award in awards:
        if award.name == 'Blue Distinction Plus':
            continue

        quality_increasing_awards = ['Blue First', 'Blue Compare']

        # initial increment
        if award.name in quality_increasing_awards:
            _increment_quality(award, 1)
        else:
            _increment_quality(award, -1)

        # decrease expires_in counter
        award.expires_in -= 1

        # increment again if expired
        if award.expires_in < 0:
            if award.name in quality_increasing_awards:
                _increment_quality(award, 1)
            else:
                _increment_quality(award, -1)


def _increment_quality(award, inc):
    if award.quality < 50 and award.quality > 0:
        if award.name == "Blue Star":
            award.quality += inc * 2
        elif award.name == 'Blue Compare' and award.expires_in < 11:
            if award.expires_in <= 0:
                award.quality = 0
            elif award.expires_in < 6:
                award.quality += 3
            elif award.expires_in < 11:
                award.quality += 2
        else:
            award.quality += inc
