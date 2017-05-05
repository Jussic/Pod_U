require 'elasticsearch/model'

module PodcastsHelper
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
end
