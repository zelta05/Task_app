User.create!(name: "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

@project = Project.create(owner_id: 1, name: "Defend the Wall", description: "defend the wall from the wildings", due_date: "2016-07-23", status: 0)
@task = Task.create(project_id: 1, owner_id: 1, name: "Secure the tunnel", description: "flood the tunnel so it can't be be breached by the wildings", due_date: "2016-07-23" )


@note = Note.create(user_id: 1, project_id: 1, title: "Watch out for climbers", content: "If the climbers start to come up the wall, drop the scythe on them. That should hold them off, for a little while anyways.")
@project.collaborators << [@ollie]
@project.save

