require 'active_record'

configure :test, :development do
  ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => 'comments.db'
  )
end

configure :production do
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
end

class Comment < ActiveRecord::Base
  def date
    self.posted_date.strftime("%Y-%m-%d %H:%M:%S")
  end

  def formatted_message
    Rack::Utils.escape_html(self.message).gsub(/\n/, "<br>")
  end
end

class CommentMigration < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :name
      t.string :title
      t.text :message
      t.timestamp :posted_date
    end
  end
end

CommentMigration.new.up unless ActiveRecord::Base.connection.table_exists? 'comments'
