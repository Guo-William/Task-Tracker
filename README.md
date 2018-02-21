# Tasktracker

decisions made:
Users will have an email and username. The email is for logging in but
the username is for assignee purposes. We do not need the users' name because
it's not necessary for task assignment. Added unique constraints on both
because we do not want multiple accounts sharing email addresses or usernames
that would create chaos!

Statustypes are its own thing in issues. I made them separate with a different
database table too. This is so that everything can reference one spelling
and indexing of the statuses. This gives the effect that it is organized
and updating any spelling or indexing for it takes place in one spot.

In this particular instance I made three kinds of statuses: Complete,
In progress, and not started

Tasks has an owner_id because it may be important to know who made the task
and to ask them questions if the task is unclear.

I also decided to use seeds.exs so that the database is populated
with the initial status types and with some initial users. This leads
to a easier time testing and a avoids problems where my code expects
status types to already be there first.

Another design decision was to allow the user to enter any number as the
timespent. I would take their input and process it to round up to the next
increment of 15.

I decided that the edit and new form would be the same for tasks. This
is because every field exposed should be subject to change at any time
in my belief.

I made a UX decision to make assignee and status select drop downs. This
allows the user to see their choices immediately without having to guess around.

You can change the status from any status to any other status. This is
because I believe that tasks/issues may need to be revisted.

Assigned users can be changed because what if someone disappears or something
still need someone to work on it.


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
