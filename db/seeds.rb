# p 'Creating users....'
# 8.times do
#   User.create(
#     telefone: Faker::PhoneNumber.cell_phone_in_e164,
#     apelido: Faker::Name.last_name,
#     name: Faker::Name.first_name,
#     dia_vencimento: 10
#   )
# end

# p 'Creating Turmas....'
# Turma.create(
#   sede: 'Arclo',
#   dia: 'Segunda e Quarta',
#   horario: '2023-03-26 21:0:0 +0000',
#   professor: Faker::Name.first_name,
#   valor: Faker::Number.between(from: 1, to: 3)
# )

# Turma.create(
#   sede: 'Viva Esportes',
#   dia: 'Terça e Quinta',
#   horario: '2023-03-26 19:0:0 +0000',
#   professor: Faker::Name.first_name,
#   valor: Faker::Number.between(from: 1, to: 3)
# )

# Turma.create(
#   sede: 'Arclo',
#   dia: 'Outros',
#   horario: '2023-03-26 8:0:0 +0000',
#   professor: Faker::Name.first_name,
#   valor: Faker::Number.between(from: 1, to: 3)
# )

p 'Creating Turma_Alunos ativos....'
18.times do
  TurmaAluno.create(
    turma_id: Faker::Number.between(from: 1, to: 3),
    user_id: Faker::Number.between(from: 1, to: 6),
    status: 'ativo'
  )
end

p 'Creating Turma_Alunos inativos....'
4.times do
  TurmaAluno.create(
    turma_id: Faker::Number.between(from: 1, to: 3),
    user_id: Faker::Number.between(from: 1, to: 6),
    status: 'inativo'
  )
end

# 12.times do |index|
#   Pagamento.create(
#     user_id: 2,
#     dia_vencimento: 10,
#     valor: 1,
#     month_id: index,
#     status: 'gerado'
#   )
# end
# ActiveRecord::Base.connection.reset_pk_sequence!('YourModelName')
