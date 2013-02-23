key =  lambda { |n| n % 10 == 1 && n % 100 != 11 ? :one : (2..4).include?(n % 10) && !(12..14).include?(n % 100) ? :few : n % 10 == 0 || (5..9).include?(n % 10) || (11..14).include?(n % 100) ? :many : :other }
{:ru  => { :i18n => { :plural => {:keys => [:one, :frew, :many, :other], :rule => key }}}}

