# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

# http://chodounsky.net/2013/04/23/nanoc-project-structure/
include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::Tagging
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo

REGEXP_DATE_ISO = /(20\d{2}\-\d{2}\-\d{2})(?:T(\d{2})(\d{2})(\d{2}))?/

# http://blog.lingohub.com/developers/2013/08/internationalization-for-ruby-i18n-gem/
require 'i18n'
I18n.enforce_available_locales = true
I18n.load_path = Dir[ File.join('.', 'lib', 'locale.??.yml') ]
I18n.default_locale = :de


class String
  # Render a localised, human readable date+time
  #
  # http://www.ruby-doc.org/stdlib-1.8.7/libdoc/date/rdoc/DateTime.html
  def to_date_time style
    t = DateTime.parse(self)
    case style
    when :human: I18n.localize t, :format => :long
    else raise "Unknown style: '#{style}'"
    end
  end
end


# Add a bit of magic.
#
class Nanoc::Item
  # Monkey-patch [] operator to automatically pick up post date from identifier
  # https://stackoverflow.com/questions/4470108/when-monkey-patching-a-method-can-you-call-the-overridden-method-from-the-new-i
  alias_method :old_acc, :[]

  def [](key)
    ret = old_acc(key)
    (ret.nil? && key == :date) ? date_from_post_path : ret
  end

  # Extract date+time from identifier.
  # 
  # default time to 19:00:00 if not part of the identifier.
  def date_from_post_path
    m = REGEXP_DATE_ISO.match(self.identifier)
    time = m[2].nil? ? '19:00:00' : m[2..4].join(':')
    return m.nil? ? nil : [m[1], time].join('T')
  end

  # Turn :title into something sensible as URL.
  def title_folded_to_filename
    self[:title].gsub(/[^a-z0-9-]/) do |c|
      case c
      when /\s+|\./: '-'
      when /[A-Z]+/: c.downcase
      else ''
      end
    end.gsub(/\-+/,'-')
  end
end


# Return array with all posts sorted by date (descending)
def sorted_posts_by_date
  @items.select do |i|
    ! ( REGEXP_DATE_ISO.match(i.identifier).nil? )
  end.sort do |a,b|
    a.identifier <=> b.identifier
  end.reverse
end
