if !Rails.env.development?
  Gem.path.each do |path|
    Warning.ignore(//, path)
  end
end