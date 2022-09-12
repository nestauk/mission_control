ActiveSupport.on_load(:action_text_rich_text) do
  ActionText::RichText.class_eval do
    before_save :record_change

    private

    def record_change
      return unless body_changed?

      Audited::Audit.create(
        auditable_id: id, auditable_type: self.class,
        associated_id: record.id, associated_type: record.class,
        action: 'update',
        audited_changes: { name => [body_was&.to_html, body.to_html] }
      )
    end
  end
end
