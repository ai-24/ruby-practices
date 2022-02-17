# frozen_string_literal: true

class FileListGenerator
  def self.list
    Dir.glob('*')
  end

  def self.list_all
    Dir.glob(%w[.* *])
  end
end
