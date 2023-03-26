# p 'Creating users....'
# 6.times do
#   User.create(
#     telefone: Faker::PhoneNumber.cell_phone_in_e164,
#     apelido: Faker::Name.last_name,
#     name: Faker::Name.first_name,
#     data_vencimento: 10
#   )
# end

# p 'Creating Turmas....'
# Turma.create(
#   sede: 'Sede 1',
#   dia: 'Segunda-Quarta',
#   horario: '18h',
#   professor: Faker::Name.first_name,
#   valor: Faker::Number.between(from: 1, to: 3)
# )

# Turma.create(
#   sede: 'Sede 2',
#   dia: 'Terça-Quinta',
#   horario: '19h',
#   professor: Faker::Name.first_name,
#   valor: Faker::Number.between(from: 1, to: 3)
# )

# Turma.create(
#   sede: 'Sede 1',
#   dia: 'Sábado-Domingo',
#   horario: '8h',
#   professor: Faker::Name.first_name,
#   valor: Faker::Number.between(from: 1, to: 3)
# )

# p 'Creating Turma_Alunos ativos....'
# 12.times do
#   TurmaAluno.create(
#     turma_id: Faker::Number.between(from: 1, to: 3),
#     user_id: Faker::Number.between(from: 1, to: 6),
#     status: 'ativo'
#   )
# end

# p 'Creating Turma_Alunos inativos....'
# 2.times do
#   TurmaAluno.create(
#     turma_id: Faker::Number.between(from: 1, to: 3),
#     user_id: Faker::Number.between(from: 1, to: 6),
#     status: 'inativo'
#   )
# end

12.times do |index|
  Pagamento.create(
    user_id: 2,
    dia_vencimento: 10,
    valor: 1,
    month_id: index,
    status: 'gerado'
  )
end
# ActiveRecord::Base.connection.reset_pk_sequence!('YourModelName')
