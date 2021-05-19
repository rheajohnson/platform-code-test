require "award"

def update_quality(awards)
  awards.each do |award|
    next if award.name == "Blue Distinction Plus"

    quality_increasing_awards = ["Blue First", "Blue Compare"]

    # initial increment
    if quality_increasing_awards.include? award.name
      _increment_quality(award, 1)
    else
      _increment_quality(award, -1)
    end

    # decrease expires_in counter
    award.expires_in -= 1

    # increment again if expired
    if award.expires_in < 0
      if quality_increasing_awards.include? award.name
        _increment_quality(award, 1)
      else
        _increment_quality(award, -1)
      end
    end
  end
end

def _increment_quality(award, inc)
  if award.quality < 50 and award.quality > 0
    if award.name == "Blue Star"
      award.quality += inc * 2
    elsif award.name == "Blue Compare" and award.expires_in < 11
      if award.expires_in <= 0
        award.quality = 0
      elsif award.expires_in < 6
        award.quality += 3
      elsif award.expires_in < 11
        award.quality += 2
      end
    else award.quality += inc     end
  end
end
