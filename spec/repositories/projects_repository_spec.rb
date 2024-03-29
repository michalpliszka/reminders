require "rails_helper"

describe ProjectsRepository do
  let(:repo) { described_class.new }

  describe "#all" do
    before do
      2.times { create(:project) }
    end

    it "returns all projects" do
      expect(repo.all.count).to eq 2
    end
  end

  describe "#find" do
    let(:project) { create(:project, name: "reminders") }
    let(:id) { project.id }

    it "returns project with given id" do
      expect(repo.find(id).name).to eq "reminders"
    end
  end

  describe "#persist" do
    let(:project_check) do
      Project.new(
        name: "reminders",
      )
    end

    it "saves given entity" do
      expect(repo.all.count).to eq 0
      repo.persist(project_check)
      expect(repo.all.count).to eq 1
    end
  end

  describe "#for_reminder" do
    let(:reminder) { create(:reminder) }
    let(:project) { create(:project) }

    before do
      create(:project_check, project: project, reminder: reminder)
      create(:project)
    end

    it "returns projects for given reminder" do
      expect(repo.all.count).to eq 2
      expect(repo.for_reminder(reminder).count).to eq 1
    end
  end

  describe "#update" do
    let(:project) { create(:project, enabled: false, name: "some_name") }

    it "updates project's given attributes" do
      repo.update(project, enabled: true, name: "other_name")
      expect(project.enabled).to be true
      expect(project.name).to eq "other_name"
    end
  end
end
