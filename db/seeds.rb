# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

super_role = Role.find_or_initialize_by_name(name: "super", description: "Супер администратор")
super_role.save!
admin_role = Role.find_or_initialize_by_name(name: "admin", description: "Администратор")
admin_role.save!
profile = Profile.find_or_initialize_by_mail(surname: "Иванов", name: "Иван", patronymic: "Иванович", mail:"mail@mail.ru")
profile.save!
company = Company.new(name:"TheCompany", opf: "ООО")
company.save!
user = UserCreateType.find_or_initialize_by_login(login: "admin", password: '123')
user.role = super_role
user.profile = profile
user.company = company
user.save!
