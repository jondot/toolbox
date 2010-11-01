require 'rubygems'
require 'bundler/setup'
require 'xmlsimple'
require 'yaml'


def work_node(root_node, i=0)
    
    return nil unless root_node["node"].respond_to? :each
    
    a =[]
    root_node["node"].each do |node|
      #puts ("  "*i) + node["TEXT"].to_s
      
      res = work_node(node, i+1)
      if(res.kind_of? Array)
        a << {node["TEXT"].to_s => res}
      else
        a << node["TEXT"].to_s
      end
    end
    return a
end

@d= XmlSimple.xml_in(ARGF.read)

hs = work_node @d, 0


puts hs.to_yaml
