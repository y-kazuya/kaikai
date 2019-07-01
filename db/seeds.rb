# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


public_note_categories = ["食事", "介助","趣味趣向","親族・家族", "接し方"]

public_note_categories.each do |cate|
  NoteCategory.create(name: cate, public: true)
end

checks = [["排泄回数", 0], ["食事済", 0],["水分補給量", 0],["薬昼", 1],["薬夜", 1]]

checks.each do |check|
  Check.create(title: check[0],kind: check[1] , public: true)
end