require 'pstore'

module IPlist
  class DB

    def initialize (name)
      @db = PStore.new ("#{name}.pstore")
    end

    # create db if it does not exist
    def write(data)
      id = get_last + 1
      if data.is_a?(Hash)
        @db.transaction do
          @db[id] = data
          @db.commit
        end
      end
    end

    def read(id)
      @db.transaction do
        @db.fetch(id)
        @db.commit
      end
    end

    def get_ids
      ret = []
      @db.transaction(true) do
        @db.roots.each do |entry|
          ret.push(entry)
        end
      end
      # puts "ret: #{ret}"
      return ret
    end

    def get_all
      ret = {}
      @db.transaction(true) do
        @db.roots.each do |entry|
          ret.store(entry, @db[entry])
        end
      end
      return ret
    end

    def path
      @db.path
    end

    def get_last
      ids = get_ids
      # puts "size #{ids.size}"
      if ids.size == 0
        return 0
      else
        return ids.last
      end
    end

    def delete_all
      ids = get_all
      @db.transaction do
        ids.each do |id|
          @db.delete(id)
        end
      end
    end
  end
end
