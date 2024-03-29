class ProjectDecorator < Draper::Decorator
  delegate :id, :name, :enabled

  def created_at
    h.l object.created_at
  end

  def channel_name
    "##{object.channel_name}"
  end

  def row_class
    "active" unless object.enabled?
  end

  def checked_reviews
    ::ProjectCheckDecorator.decorate_collection object.checked_reviews
  end

  def checks
    ::ProjectCheckDecorator.decorate_collection object.project_checks
  end

  def has_checked_reviews?
    checked_reviews.any?
  end

  def show_history
    if project.checked_reviews.length > 0
      h.link_to "Show", h.history_project_path(project.id),
                class: "btn btn-success"
    else
      "nothing to show"
    end
  end

  def email
    "#{slugified_name}-team@netguru.pl"
  end

  def slugified_name
    name.sub(" ", "-")
  end
end
