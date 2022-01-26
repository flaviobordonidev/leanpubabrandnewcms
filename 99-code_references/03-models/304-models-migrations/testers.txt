# Testers




## db




#### 01 {#code-migrations-testers-db-01}

{title="db/migrations/xxx_remove_lab_from_testers.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class RemoveLabFromTesters < ActiveRecord::Migration

  def up
    remove_column :testers, :lab
  end

  def down
    add_column :testers, :lab, :string
  end

end
~~~~~~~~




#### 02 {#code-migrations-testers-db-02}

{title="db/migrations/xxx_change_lab_in_testers.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class ChangeLabInTesters < ActiveRecord::Migration
  def up
      change_column :testers, :lab, :text
  end

   def down
      change_column :testers, :lab, :string
  end
end
~~~~~~~~




#### 03 {#code-migrations-testers-db-03}

{title="db/migrations/xxx_add_index_to_lab_in_testers.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class AddIndexToLabInTester < ActiveRecord::Migration
  def change
    add_index :testers, :lab, unique: false
  end
end
~~~~~~~~




#### 04 {#code-migrations-testers-db-04}

{title="db/migrations/xxx_remove_index_to_lab_in_testers.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class RemoveIndexToLabInTesters < ActiveRecord::Migration
  def up
    remove_index :testers, :lab
  end

  def down
    add_index :testers, :lab, unique: false
  end
end
~~~~~~~~




#### 05 {#code-migrations-testers-db-05}

{title="db/migrations/xxx_add_user_reference_to_testers.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class AddUserReferenceToTester < ActiveRecord::Migration
  def change
    add_column :testers, :user_id, :integer
    add_index :testers, :user_id
  end
end
~~~~~~~~




#### 06 {#code-migrations-testers-db-06}

{title="db/migrations/xxx_add_user_id_to_testers.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class AddUserIdToTesters < ActiveRecord::Migration
  def change
    add_column :testers, :user_id, :integer
    add_index :testers, :user_id
  end
end
~~~~~~~~




## models




#### 01 {#code-migrations-testers-models-01}

{title="models/tester.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class Tester < ActiveRecord::Base
  belongs_to :user
end
~~~~~~~~
