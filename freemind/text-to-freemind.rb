require 'yaml'
require 'rexml/document'

def create_node(parentnode, text)
	el = parentnode.add_element('node')
	el.add_attribute 'CREATED', Time.new.to_i*1000
	el.add_attribute 'MODIFIED', Time.new.to_i*1000
	el.add_attribute 'TEXT', text
	el
end
def add_node(node, root)
	if root.respond_to? :keys
		root.each do |k,v|
			el = create_node(node, k)
			add_node el, v
		end
	elsif root.kind_of? Array
		root.each do |v|
			add_node node, v
		end
	else
		create_node(node, root.to_s)
	end
end

y = YAML::load(ARGF)
doc = REXML::Document.new()
doc.add_element('map').add_attribute('version','0.8.0')
add_node doc.root, y

doc.write
