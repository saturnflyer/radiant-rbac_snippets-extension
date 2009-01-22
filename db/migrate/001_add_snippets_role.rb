class AddSnippetsRole < ActiveRecord::Migration
  def self.up
    if Role.create!(:role_name => 'Snippets', :description => 'Uses in this role will be able to edit Snippets.')
      puts "Snippets role created."
    end
  end
  def self.down
    Role.find_by_role_name('Snippets').destroy
  end
end