require 'elasticsearch/model'

module EpisodesHelper
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
end
