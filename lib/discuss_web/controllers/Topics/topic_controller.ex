defmodule DiscussWeb.Topics.TopicController do
  use DiscussWeb, :controller

  alias Discuss.{Repo, Topic}

  def index(conn, _params) do
    topics = Repo.all(Discuss.Topic)

    render(conn, :index, topics: topics, layout: false)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, :new, changeset: changeset, layout: false)
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: "/topics")
      {:error, changeset} ->
        render(conn, :new, changeset: changeset, layout: false)
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render(conn, :edit, changeset: changeset, topic: topic, layout: false)
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)
    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: "/topics")
      {:error, changeset} ->
        render(conn, :edit, changeset: changeset, topic: old_topic, layout: false)
    end
  end
end
