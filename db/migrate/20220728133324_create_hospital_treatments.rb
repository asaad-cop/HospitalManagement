class CreateHospitalTreatments < ActiveRecord::Migration[5.2]
  def change
    create_table :hospital_treatments do |t|
      t.integer :price
      t.references :hospital, foreign_key: true
      t.references :treatment, foreign_key: true

      t.timestamps
    end
  end
end
