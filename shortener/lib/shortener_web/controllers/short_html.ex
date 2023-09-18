defmodule ShortenerWeb.ShortHTML do
  use ShortenerWeb, :html

  embed_templates "short_html/*"

  @doc """
  Renders a short form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def short_form(assigns)
end
