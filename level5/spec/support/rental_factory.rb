def build_rental(
  id: 1,
  car_id: 1,
  start_date: '2023-01-01',
  end_date: '2023-01-03',
  distance: 100
)
  Rental.new(
    id: id,
    car_id: car_id,
    start_date: start_date,
    end_date: end_date,
    distance: distance
  )
end