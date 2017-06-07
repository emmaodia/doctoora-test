# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Plan.create([{ title: "Basic Care Plan", description: "Plan 1", price: 500},
	{ title: "Premium Care Plan", description: "Plan 2", price: 1000},
	{ title: "Gold Care Plan", description: "Plan 3", price: 1500},
	{ title: "Specialist Consultation", description: "Plan 4", price: 2000},
	{ title: "GP Consultation", description: "Plan 5", price: 2500}])