# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

# http://chodounsky.net/2013/04/23/nanoc-project-structure/
include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::Tagging
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo

REGEXP_DATE_ISO = /(20\d{2}\-\d{2}\-\d{2})(?:T(\d{2})(\d{2})(\d{2}))?/                     unless defined? REGEXP_DATE_ISO
REGEXP_POSTS_DATE_ISO = /^\/posts\/(20\d{2}\-\d{2}\-\d{2})(?:T(\d{2})(\d{2})(\d{2}))?\/$/  unless defined? REGEXP_POSTS_DATE_ISO

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
    when :human   then I18n.localize t, :format => :long
    when :default then I18n.localize t, :format => :default
    else raise "Unknown style: '#{style}'"
    end
  end

  # Turn :title into something sensible as part of an URL.
  def title_folded_to_filename
    self.gsub(/[^a-z0-9-]/) do |c|
      case c
      when /\s+|\./ then '-'
      when /[A-Z]+/ then c.downcase
      else ''
      end
    end.gsub(/\-+/,'-')
  end
end


class Nanoc::Item
  # Extract date+time from identifier.
  # 
  # default time to 19:00:00 if not part of the identifier.
  def date_from_post_identifier
    m = REGEXP_POSTS_DATE_ISO.match(self.identifier)
    return nil if m.nil?
    time = m[2].nil? ? '19:00:00' : m[2..4].join(':')
    [m[1], time].join('T')
  end
end


# Return array with all posts sorted by date (descending)
def sorted_posts_by_date
  @items.select do |i|
    ! ( i[:date].nil? )
  end.sort do |a,b|
    a[:date] <=> b[:date]
  end.reverse
end
