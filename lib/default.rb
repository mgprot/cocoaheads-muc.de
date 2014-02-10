# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

# http://chodounsky.net/2013/04/23/nanoc-project-structure/
include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::Tagging
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo

# http://blog.lingohub.com/developers/2013/08/internationalization-for-ruby-i18n-gem/
require 'i18n'
I18n.enforce_available_locales = true
I18n.load_path = Dir[ File.join('.', 'lib', 'locale.??.yml') ]
I18n.default_locale = :de

class String
  # http://www.ruby-doc.org/stdlib-1.8.7/libdoc/date/rdoc/DateTime.html
  def to_date_time style
  	t = DateTime.parse(self)
  	case style
  	when :human: I18n.localize t, :format => :long
  	else raise "Unknown style: '#{style}'"
  	end
  end
end

def sorted_articles_by_key(key)
  articles.sort_by do |a|
    attribute_to_time(a[key])
  end.reverse
end
