# AR association validations

## Setup

- Department has_many Users has_many Posts
- Department and Post have validations

## has_many with invalid child

Parent fails validation, does not save.

## belongs_to with invalid parent with no id

    irb(main):004:0> u=User.new
    => #<User id: nil, name: nil, created_at: nil, updated_at: nil, department_id: nil>
    irb(main):005:0> u.department=Department.new
    => #<Department id: nil, name: nil, created_at: nil, updated_at: nil>
    irb(main):006:0> u.save
       (0.1ms)  begin transaction
      User Create (0.3ms)  INSERT INTO "users" ("created_at", "updated_at") VALUES (?, ?)  [["created_at", "2018-10-02 20:02:04.013669"], ["updated_at", "2018-10-02 20:02:04.013669"]]
       (8.6ms)  commit transaction
    => true
    irb(main):007:0> u.department
    => #<Department id: nil, name: nil, created_at: nil, updated_at: nil>
    irb(main):008:0> u.department_id
    => nil
    irb(main):009:0> u.reload
      User Load (0.2ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 5], ["LIMIT", 1]]
    => #<User id: 5, name: nil, created_at: "2018-10-02 20:02:04", updated_at: "2018-10-02 20:02:04", department_id: nil>
    irb(main):010:0> u.department
    => nil

Saves with parent id set to nil, possible data loss.

## belongs_to with parent_id set to a nonexistent parent

Child fails validation, does not save.

    irb(main):012:0> u.department_id=8
    => 8
    irb(main):013:0> u.save
       (0.1ms)  begin transaction
      Department Load (0.2ms)  SELECT  "departments".* FROM "departments" WHERE "departments"."id" = ? LIMIT ?  [["id", 8], ["LIMIT", 1]]
       (0.0ms)  rollback transaction
    => false

Since mongoid does generate ids for all models, this behavior is closer
to what I would consider appropriate for mongoid even with non-persisted
parents.
