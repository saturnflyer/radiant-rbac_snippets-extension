# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class RbacSnippetsExtension < Radiant::Extension
  version "1.0"
  description "Uses RBAC Base to change the editors of Snippets."
  url "http://saturnflyer.com/"
  
  class MissingRequirement < StandardError; end
  
  def activate
    Admin::SnippetsController.class_eval {
      only_allow_access_to(:index, :new, :edit, :update, :create, :destroy,
        :when => :snippets,
        :denied_url => {:controller => 'welcome', :action => 'index'},
        :denied_message => "You do not have access rights for Snippets.")
    }
  end
  
  def deactivate
  end
  
end