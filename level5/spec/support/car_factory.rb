def build_car(id: 1, price_per_day: 2000, price_per_km: 10)
  Car.new(
    id: id,
    price_per_day: price_per_day,
    price_per_km: price_per_km
  )
end