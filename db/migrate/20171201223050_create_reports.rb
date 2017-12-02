class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.string :report_type
      t.string :event_type
      t.string :drive_mode

      t.timestamps
    end
  end
end
# The report_type json object contains three string properties:
# 
# report_type (can be "Standard Report" or "Event Report")
# drive_mode: (can be Test Drive or Automatic mode)
# event_type: if an Event Report, then this prop will have event type valuel