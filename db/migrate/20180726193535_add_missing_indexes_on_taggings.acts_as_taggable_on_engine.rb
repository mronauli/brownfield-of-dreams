# frozen_string_literal: true

# This migration comes from acts_as_taggable_on_engine (originally 6)
if ActiveRecord.gem_version >= Gem::Version.new('5.0')
  class AddMissingIndexesOnTaggings < ActiveRecord::Migration[4.2]; end
else
  class AddMissingIndexesOnTaggings < ActiveRecord::Migration; end
end
AddMissingIndexesOnTaggings.class_eval do
  # rubocop:todo Metrics/PerceivedComplexity
  # rubocop:todo Metrics/MethodLength
  # rubocop:todo Metrics/AbcSize
  def change # rubocop:todo Metrics/CyclomaticComplexity
    add_index :taggings, :tag_id unless index_exists? :taggings, :tag_id
    unless index_exists? :taggings, :taggable_id
      add_index :taggings, :taggable_id
    end
    unless index_exists? :taggings, :taggable_type
      add_index :taggings, :taggable_type
    end
    add_index :taggings, :tagger_id unless index_exists? :taggings, :tagger_id
    add_index :taggings, :context unless index_exists? :taggings, :context

    unless index_exists? :taggings, %i[tagger_id tagger_type]
      add_index :taggings, %i[tagger_id tagger_type]
    end

    # rubocop:todo Style/GuardClause
    unless index_exists? :taggings, %i[taggable_id taggable_type tagger_id context], name: 'taggings_idy'
      add_index :taggings, %i[taggable_id taggable_type tagger_id context], name: 'taggings_idy'
    end
    # rubocop:enable Style/GuardClause
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/PerceivedComplexity
end
