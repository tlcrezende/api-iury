class CreateTurmaAlunos < ActiveRecord::Migration[7.0]
  def change
    create_table :turma_alunos do |t|
      t.references :turma, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
