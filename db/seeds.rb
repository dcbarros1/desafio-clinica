# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times do
    consulta = Faker::Time.between(7.days.ago,Date.today,:morning)
    Agenda.create({
        paciente: Faker::Name.name,
        medico: 'Médico 1',
        especialidade: 'Clínico Geral',
        consulta: consulta,
        fim_consulta: consulta + 30.minutes
    })    
end