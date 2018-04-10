# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180409172141) do

  create_table "actions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "date"
    t.text "descriptif"
    t.bigint "anomalie_id"
    t.bigint "plan_action_types_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["anomalie_id"], name: "index_actions_on_anomalie_id"
    t.index ["plan_action_types_id"], name: "index_actions_on_plan_action_types_id"
  end

  create_table "anomalies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "statut"
    t.datetime "date"
    t.text "descriptif"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "nom"
    t.string "prenom"
    t.string "mail"
    t.string "adresse"
    t.string "telephone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "droits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "type"
    t.bigint "utilisateurs_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["utilisateurs_id"], name: "index_droits_on_utilisateurs_id"
  end

  create_table "historiques", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "date"
    t.text "evenements"
    t.string "utilisateur"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plan_action_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "type"
    t.text "descriptif"
    t.string "liste_action"
    t.datetime "temps"
    t.string "priorite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "societes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "nom"
    t.string "referent_technique"
    t.bigint "client_id"
    t.bigint "anomalie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["anomalie_id"], name: "index_societes_on_anomalie_id"
    t.index ["client_id"], name: "index_societes_on_client_id"
  end

  create_table "utilisateurs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "nom"
    t.string "password"
    t.bigint "actions_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actions_id"], name: "index_utilisateurs_on_actions_id"
  end

  add_foreign_key "actions", "anomalies", column: "anomalie_id"
  add_foreign_key "actions", "plan_action_types", column: "plan_action_types_id"
  add_foreign_key "droits", "utilisateurs", column: "utilisateurs_id"
  add_foreign_key "societes", "anomalies", column: "anomalie_id"
  add_foreign_key "societes", "clients"
  add_foreign_key "utilisateurs", "actions", column: "actions_id"
end
