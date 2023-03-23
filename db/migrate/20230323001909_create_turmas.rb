class CreateTurmas < ActiveRecord::Migration[7.0]
  def change
    create_table :turmas do |t|
      t.string :sede
      t.string :dia
      t.string :horario
      t.string :professor
      t.float :valor

      t.timestamps
    end
  end
end
