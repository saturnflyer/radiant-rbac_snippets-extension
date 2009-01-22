namespace :radiant do
  namespace :extensions do
    namespace :rbac_snippets do
      
      desc "Runs the migration of the Rbac Snippets extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          RbacSnippetsExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          RbacSnippetsExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Rbac Snippets to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[RbacSnippetsExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(RbacSnippetsExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
