json.lights do
  @lights.each do |l|
    json.set! l.light_id do
      json.id l.id
      json.name l.name
    end
  end
end
