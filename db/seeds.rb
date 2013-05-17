# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

super_role = Role.find_or_initialize_by_name(name: configus.role.super_admin.name, description: configus.role.super_admin.description)
super_role.save!
admin_role = Role.find_or_initialize_by_name(name: configus.role.admin.name, description: configus.role.admin.description)
admin_role.save!
profile = Profile.find_or_initialize_by_mail(surname: configus.super_admin.profile.surname,
                                             name: configus.super_admin.profile.name,
                                             patronymic: configus.super_admin.profile.patronymic,
                                             mail: configus.super_admin.profile.mail)
profile.save!
company = Company.new(name: configus.super_admin.company.name, opf: configus.super_admin.company.opf)
company.save!
user = User.find_or_initialize_by_login(configus.super_admin.user.login)
user.password = configus.super_admin.user.password
user.role = super_role
user.profile = profile
user.company = company
user.save!
