---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_app_user_app_tenant
  create index if not exists 
    idx_auth_app_user_app_tenant_id
  on 
    auth.app_user
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_contact_app_user_app_tenant
  create index if not exists 
    idx_org_contact_app_user_app_tenant_id
  on 
    org.contact_app_user
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_affiliation_app_tenant
  create index if not exists 
    idx_org_affiliation_app_tenant_id
  on 
    org.affiliation
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_affiliation_organization_app_tenant
  create index if not exists 
    idx_org_affiliation_organization_app_tenant_id
  on 
    org.affiliation_organization
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_affiliation_organization_organization
  create index if not exists 
    idx_org_affiliation_organization_organization_id
  on 
    org.affiliation_organization
  using btree(
    organization_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_affiliation_organization_affiliation
  create index if not exists 
    idx_org_affiliation_organization_affiliation_id
  on 
    org.affiliation_organization
  using btree(
    affiliation_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_affiliation_contact_app_tenant
  create index if not exists 
    idx_org_affiliation_contact_app_tenant_id
  on 
    org.affiliation_contact
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_affiliation_contact_contact
  create index if not exists 
    idx_org_affiliation_contact_contact_id
  on 
    org.affiliation_contact
  using btree(
    contact_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_affiliation_contact_affiliation
  create index if not exists 
    idx_org_affiliation_contact_affiliation_id
  on 
    org.affiliation_contact
  using btree(
    affiliation_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_facility_app_tenant
  create index if not exists 
    idx_org_facility_app_tenant_id
  on 
    org.facility
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_facility_organization
  create index if not exists 
    idx_org_facility_organization_id
  on 
    org.facility
  using btree(
    organization_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_facility_location
  create index if not exists 
    idx_org_facility_location_id
  on 
    org.facility
  using btree(
    location_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_organization_app_tenant
  create index if not exists 
    idx_org_organization_app_tenant_id
  on 
    org.organization
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_organization_location
  create index if not exists 
    idx_org_organization_location_id
  on 
    org.organization
  using btree(
    location_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_organization_primary_contact
  create index if not exists 
    idx_org_organization_primary_contact_id
  on 
    org.organization
  using btree(
    primary_contact_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_location_app_tenant
  create index if not exists 
    idx_org_location_app_tenant_id
  on 
    org.location
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_contact_app_tenant
  create index if not exists 
    idx_org_contact_app_tenant_id
  on 
    org.contact
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_contact_organization
  create index if not exists 
    idx_org_contact_organization_id
  on 
    org.contact
  using btree(
    organization_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_contact_location
  create index if not exists 
    idx_org_contact_location_id
  on 
    org.contact
  using btree(
    location_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_evt_app_tenant
  create index if not exists 
    idx_evt_evt_app_tenant_id
  on 
    evt.evt
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_evt_created_by
  create index if not exists 
    idx_evt_evt_created_by_app_user_id
  on 
    evt.evt
  using btree(
    created_by_app_user_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_evt_type
  create index if not exists 
    idx_evt_evt_evt_type
  on 
    evt.evt
  using btree(
    evt_type
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_evt_type_order_field
  create index if not exists 
    idx_evt_evt_type_ordering_field
  on 
    evt.evt_type
  using btree(
    ordering_field
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_evt_type_subscriberevt_type
  create index if not exists 
    idx_evt_evt_type_subscriber_evt_type
  on 
    evt.evt_type_subscriber
  using btree(
    evt_type
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_evt_consumption_evt
  create index if not exists 
    idx_evt_evt_consumption_evt_id
  on 
    evt.evt_consumption
  using btree(
    evt_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_evt_consumption_evt_type_subscriber
  create index if not exists 
    idx_evt_evt_consumption_evt_type_subscriber_id
  on 
    evt.evt_consumption
  using btree(
    evt_type_subscriber_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_message_app_tenant
  create index if not exists 
    idx_msg_message_app_tenant_id
  on 
    msg.message
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_message_created_by
  create index if not exists 
    idx_msg_message_created_by_app_user_id
  on 
    msg.message
  using btree(
    created_by_app_user_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_message_delivery_app_tenant
  create index if not exists 
    idx_msg_message_delivery_app_tenant_id
  on 
    msg.message_delivery
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_message_delivery_message
  create index if not exists 
    idx_msg_message_delivery_message_id
  on 
    msg.message_delivery
  using btree(
    message_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_message_delivery_to_contact
  create index if not exists 
    idx_msg_message_delivery_to_contact_id
  on 
    msg.message_delivery
  using btree(
    to_contact_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_task_role_app_tenant
  create index if not exists 
    idx_prj_task_role_app_tenant_id
  on 
    prj.task_role
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_contact_task_role_app_tenant
  create index if not exists 
    idx_prj_contact_task_role_app_tenant_id
  on 
    prj.contact_task_role
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_contact_task_role_task
  create index if not exists 
    idx_prj_contact_task_role_task_id
  on 
    prj.contact_task_role
  using btree(
    task_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_contact_task_role_contact
  create index if not exists 
    idx_prj_contact_task_role_contact_id
  on 
    prj.contact_task_role
  using btree(
    contact_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_contact_task_role_task_role
  create index if not exists 
    idx_prj_contact_task_role_task_role_id
  on 
    prj.contact_task_role
  using btree(
    task_role_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_task_note_prj_note
  create index if not exists 
    idx_prj_task_note_prj_note_id
  on 
    prj.task_note
  using btree(
    prj_note_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_task_note_task
  create index if not exists 
    idx_prj_task_note_task_id
  on 
    prj.task_note
  using btree(
    task_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_task_note_app_tenant
  create index if not exists 
    idx_prj_task_note_app_tenant_id
  on 
    prj.task_note
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_project_app_tenant
  create index if not exists 
    idx_prj_project_app_tenant_id
  on 
    prj.project
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_project_organization_id
  create index if not exists 
    idx_prj_project_organization_id
  on 
    prj.project
  using btree(
    organization_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_project_note_prj_note
  create index if not exists 
    idx_prj_project_note_prj_note_id
  on 
    prj.project_note
  using btree(
    prj_note_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_project_note_project
  create index if not exists 
    idx_prj_project_note_project_id
  on 
    prj.project_note
  using btree(
    project_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_project_note_app_tenant
  create index if not exists 
    idx_prj_project_note_app_tenant_id
  on 
    prj.project_note
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_prj_note_app_tenant
  create index if not exists 
    idx_prj_prj_note_app_tenant_id
  on 
    prj.prj_note
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_prj_note_contact
  create index if not exists 
    idx_prj_prj_note_created_by_contact_id
  on 
    prj.prj_note
  using btree(
    created_by_contact_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_milestone_note_prj_note
  create index if not exists 
    idx_prj_milestone_note_prj_note_id
  on 
    prj.milestone_note
  using btree(
    prj_note_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_milestone_note_milestone
  create index if not exists 
    idx_prj_milestone_note_milestone_id
  on 
    prj.milestone_note
  using btree(
    milestone_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_milestone_note_app_tenant
  create index if not exists 
    idx_prj_milestone_note_app_tenant_id
  on 
    prj.milestone_note
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_task_app_tenant
  create index if not exists 
    idx_prj_task_app_tenant_id
  on 
    prj.task
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_task_project
  create index if not exists 
    idx_prj_task_project_id
  on 
    prj.task
  using btree(
    project_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_task_milestone
  create index if not exists 
    idx_prj_task_milestone_id
  on 
    prj.task
  using btree(
    milestone_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_task_dependency_parent
  create index if not exists 
    idx_prj_task_dependency_parent_task_id
  on 
    prj.task_dependency
  using btree(
    parent_task_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_task_dependency_child
  create index if not exists 
    idx_prj_task_dependency_child_task_id
  on 
    prj.task_dependency
  using btree(
    child_task_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_task_dependency_app_tenant
  create index if not exists 
    idx_prj_task_dependency_app_tenant_id
  on 
    prj.task_dependency
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_milestone_app_tenant
  create index if not exists 
    idx_prj_milestone_app_tenant_id
  on 
    prj.milestone
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_milestone_project
  create index if not exists 
    idx_prj_milestone_project_id
  on 
    prj.milestone
  using btree(
    project_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_milestone_dependency_parent
  create index if not exists 
    idx_prj_milestone_dependency_parent_milestone_id
  on 
    prj.milestone_dependency
  using btree(
    parent_milestone_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_milestone_dependency_child
  create index if not exists 
    idx_prj_milestone_dependency_child_milestone_id
  on 
    prj.milestone_dependency
  using btree(
    child_milestone_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_milestone_dependency_app_tenant
  create index if not exists 
    idx_prj_milestone_dependency_app_tenant_id
  on 
    prj.milestone_dependency
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_sound_person_app_tenant
  create index if not exists 
    idx_tunz_sound_person_app_tenant_id
  on 
    tunz.sound_person
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_sound_person_show
  create index if not exists 
    idx_tunz_sound_person_show_id
  on 
    tunz.sound_person
  using btree(
    show_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_sound_person_contact
  create index if not exists 
    idx_tunz_sound_person_contact_id
  on 
    tunz.sound_person
  using btree(
    contact_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_venue_app_tenant
  create index if not exists 
    idx_tunz_venue_app_tenant_id
  on 
    tunz.venue
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_venue_organization
  create index if not exists 
    idx_tunz_venue_organization_id
  on 
    tunz.venue
  using btree(
    organization_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_venue_location
  create index if not exists 
    idx_tunz_venue_location_id
  on 
    tunz.venue
  using btree(
    location_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_venue_facility
  create index if not exists 
    idx_tunz_venue_facility_id
  on 
    tunz.venue
  using btree(
    facility_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_promoter_app_tenant
  create index if not exists 
    idx_tunz_promoter_app_tenant_id
  on 
    tunz.promoter
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_promoter_show
  create index if not exists 
    idx_tunz_promoter_show_id
  on 
    tunz.promoter
  using btree(
    show_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_promoter_contact
  create index if not exists 
    idx_tunz_promoter_contact_id
  on 
    tunz.promoter
  using btree(
    contact_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_studio_app_tenant
  create index if not exists 
    idx_tunz_studio_app_tenant_id
  on 
    tunz.studio
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_studio_organization
  create index if not exists 
    idx_tunz_studio_organization_id
  on 
    tunz.studio
  using btree(
    organization_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_studio_location
  create index if not exists 
    idx_tunz_studio_location_id
  on 
    tunz.studio
  using btree(
    location_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_studio_facility
  create index if not exists 
    idx_tunz_studio_facility_id
  on 
    tunz.studio
  using btree(
    facility_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_band_member_app_tenant
  create index if not exists 
    idx_tunz_band_member_app_tenant_id
  on 
    tunz.band_member
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_band_member_band
  create index if not exists 
    idx_tunz_band_member_band_id
  on 
    tunz.band_member
  using btree(
    band_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_band_member_musician
  create index if not exists 
    idx_tunz_band_member_musician_id
  on 
    tunz.band_member
  using btree(
    musician_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_recording_engineer_app_tenant
  create index if not exists 
    idx_tunz_recording_engineer_app_tenant_id
  on 
    tunz.recording_engineer
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_recording_engineer_studio_session
  create index if not exists 
    idx_tunz_recording_engineer_studio_session_id
  on 
    tunz.recording_engineer
  using btree(
    studio_session_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_recording_engineer_contact
  create index if not exists 
    idx_tunz_recording_engineer_contact_id
  on 
    tunz.recording_engineer
  using btree(
    contact_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_mixing_engineer_app_tenant
  create index if not exists 
    idx_tunz_mixing_engineer_app_tenant_id
  on 
    tunz.mixing_engineer
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_mixing_engineer_studio_session
  create index if not exists 
    idx_tunz_mixing_engineer_studio_session_id
  on 
    tunz.mixing_engineer
  using btree(
    studio_session_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_mixing_engineer_contact
  create index if not exists 
    idx_tunz_mixing_engineer_contact_id
  on 
    tunz.mixing_engineer
  using btree(
    contact_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_mastering_engineer_app_tenant
  create index if not exists 
    idx_tunz_mastering_engineer_app_tenant_id
  on 
    tunz.mastering_engineer
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_mastering_engineer_studio_session
  create index if not exists 
    idx_tunz_mastering_engineer_studio_session_id
  on 
    tunz.mastering_engineer
  using btree(
    studio_session_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_mastering_engineer_contact
  create index if not exists 
    idx_tunz_mastering_engineer_contact_id
  on 
    tunz.mastering_engineer
  using btree(
    contact_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_studio_session_app_tenant
  create index if not exists 
    idx_tunz_studio_session_app_tenant_id
  on 
    tunz.studio_session
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_studio_session_studio
  create index if not exists 
    idx_tunz_studio_session_studio_id
  on 
    tunz.studio_session
  using btree(
    studio_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_producer_app_tenant
  create index if not exists 
    idx_tunz_producer_app_tenant_id
  on 
    tunz.producer
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_producer_studio_session
  create index if not exists 
    idx_tunz_producer_studio_session_id
  on 
    tunz.producer
  using btree(
    studio_session_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_producer_contact
  create index if not exists 
    idx_tunz_producer_contact_id
  on 
    tunz.producer
  using btree(
    contact_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_instrument_app_tenant
  create index if not exists 
    idx_tunz_instrument_app_tenant_id
  on 
    tunz.instrument
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_musician_instrument_app_tenant
  create index if not exists 
    idx_tunz_musician_instrument_app_tenant_id
  on 
    tunz.musician_instrument
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_musician_instrument_musician
  create index if not exists 
    idx_tunz_musician_instrument_musician_id
  on 
    tunz.musician_instrument
  using btree(
    musician_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_musician_instrument_instrument
  create index if not exists 
    idx_tunz_musician_instrument_instrument_id
  on 
    tunz.musician_instrument
  using btree(
    instrument_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_show_venue
  create index if not exists 
    idx_tunz_show_venue_id
  on 
    tunz.show
  using btree(
    venue_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_band_app_tenant
  create index if not exists 
    idx_tunz_band_app_tenant_id
  on 
    tunz.band
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_booker_app_tenant
  create index if not exists 
    idx_tunz_booker_app_tenant_id
  on 
    tunz.booker
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_booker_show
  create index if not exists 
    idx_tunz_booker_show_id
  on 
    tunz.booker
  using btree(
    show_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_booker_contact
  create index if not exists 
    idx_tunz_booker_contact_id
  on 
    tunz.booker
  using btree(
    contact_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_booking_app_tenant
  create index if not exists 
    idx_tunz_booking_app_tenant_id
  on 
    tunz.booking
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_booking_band
  create index if not exists 
    idx_tunz_booking_band_id
  on 
    tunz.booking
  using btree(
    band_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_booking_show
  create index if not exists 
    idx_tunz_booking_show_id
  on 
    tunz.booking
  using btree(
    show_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_booking_booker
  create index if not exists 
    idx_tunz_booking_booker_id
  on 
    tunz.booking
  using btree(
    booker_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_playlist_app_tenant
  create index if not exists 
    idx_tunz_playlist_app_tenant_id
  on 
    tunz.playlist
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_playlist_booking
  create index if not exists 
    idx_tunz_playlist_booking_id
  on 
    tunz.playlist
  using btree(
    booking_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_playlist_song
  create index if not exists 
    idx_tunz_playlist_song_id
  on 
    tunz.playlist
  using btree(
    song_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_repetoire_app_tenant
  create index if not exists 
    idx_tunz_repetoire_app_tenant_id
  on 
    tunz.repetoire
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_repetoire_song_app_tenant
  create index if not exists 
    idx_tunz_repetoire_song_app_tenant_id
  on 
    tunz.repetoire_song
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_repetoire_song_repetoire
  create index if not exists 
    idx_tunz_repetoire_song_repetoire_id
  on 
    tunz.repetoire_song
  using btree(
    repetoire_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_repetoire_song_song
  create index if not exists 
    idx_tunz_repetoire_song_song_id
  on 
    tunz.repetoire_song
  using btree(
    song_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_musician_app_tenant
  create index if not exists 
    idx_tunz_musician_app_tenant_id
  on 
    tunz.musician
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_musician_track_app_tenant
  create index if not exists 
    idx_tunz_musician_track_app_tenant_id
  on 
    tunz.musician_track
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_musician_track_musician
  create index if not exists 
    idx_tunz_musician_track_musician_id
  on 
    tunz.musician_track
  using btree(
    musician_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_musician_track_track
  create index if not exists 
    idx_tunz_musician_track_track_id
  on 
    tunz.musician_track
  using btree(
    track_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_song_app_tenant
  create index if not exists 
    idx_tunz_song_app_tenant_id
  on 
    tunz.song
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_writing_credit_app_tenant
  create index if not exists 
    idx_tunz_writing_credit_app_tenant_id
  on 
    tunz.writing_credit
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_writing_credit_contact
  create index if not exists 
    idx_tunz_writing_credit_contact_id
  on 
    tunz.writing_credit
  using btree(
    contact_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_writing_credit_song
  create index if not exists 
    idx_tunz_writing_credit_song_id
  on 
    tunz.writing_credit
  using btree(
    song_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_track_app_tenant
  create index if not exists 
    idx_tunz_track_app_tenant_id
  on 
    tunz.track
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_track_studio_session
  create index if not exists 
    idx_tunz_track_studio_session_id
  on 
    tunz.track
  using btree(
    studio_session_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_track_instrument
  create index if not exists 
    idx_tunz_track_instrument_id
  on 
    tunz.track
  using btree(
    instrument_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_recording_track_app_tenant
  create index if not exists 
    idx_tunz_recording_track_app_tenant_id
  on 
    tunz.recording_track
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_recording_track_recording
  create index if not exists 
    idx_tunz_recording_track_recording_id
  on 
    tunz.recording_track
  using btree(
    recording_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_recording_track_track
  create index if not exists 
    idx_tunz_recording_track_track_id
  on 
    tunz.recording_track
  using btree(
    track_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_recording_app_tenant
  create index if not exists 
    idx_tunz_recording_app_tenant_id
  on 
    tunz.recording
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_recording_song
  create index if not exists 
    idx_tunz_recording_song_id
  on 
    tunz.recording
  using btree(
    song_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_recording_studio_session
  create index if not exists 
    idx_tunz_recording_studio_session_id
  on 
    tunz.recording
  using btree(
    studio_session_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_release_app_tenant
  create index if not exists 
    idx_tunz_release_app_tenant_id
  on 
    tunz.release
  using btree(
    app_tenant_id
  );
-----------------------------

---- NEW SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_release_recording
  create index if not exists 
    idx_tunz_release_recording_id
  on 
    tunz.release
  using btree(
    recording_id
  );
-----------------------------

---- NEW MULTI-COLUMN UNIQUE-INDEX FOR CONSTRAINT: uq_facility_app_tenant_and_organization_and_name
  create index if not exists 
    idx_org_facility_name_organization_id
  on 
    org.facility
  using btree(
    name,
    organization_id
  );
-----------------------------

---- EXISTING MULTI-COLUMN UNIQUE-INDEX FOR CONSTRAINT: uq_app_tenant_external_id
  create unique index if not exists
     uq_app_tenant_external_id
  on
     org.organization
  using btree (
    app_tenant_id,
    external_id
);
-----------------------------

---- EXISTING MULTI-COLUMN UNIQUE-INDEX FOR CONSTRAINT: uq_location_app_tenant_and_external_id
  create unique index if not exists
     uq_location_app_tenant_and_external_id
  on
     org.location
  using btree (
    app_tenant_id,
    external_id
);
-----------------------------

---- EXISTING MULTI-COLUMN UNIQUE-INDEX FOR CONSTRAINT: uq_contact_app_tenant_and_email
  create unique index if not exists
     uq_contact_app_tenant_and_email
  on
     org.contact
  using btree (
    app_tenant_id,
    email
);
-----------------------------

---- EXISTING MULTI-COLUMN UNIQUE-INDEX FOR CONSTRAINT: uq_contact_app_tenant_and_external_id
  create unique index if not exists
     uq_contact_app_tenant_and_external_id
  on
     org.contact
  using btree (
    app_tenant_id,
    external_id
);
-----------------------------

---- EXISTING MULTI-COLUMN UNIQUE-INDEX FOR CONSTRAINT: uq_evt_2
  create unique index if not exists
     uq_evt_2
  on
     evt.evt
  using btree (
    evt_type,
    external_tx_id
);
-----------------------------

---- NEW MULTI-COLUMN UNIQUE-INDEX FOR CONSTRAINT: uq_evt_type_subscriber
  create index if not exists 
    idx_evt_evt_type_subscriber_consume_handler_evt_type
  on 
    evt.evt_type_subscriber
  using btree(
    consume_handler,
    evt_type
  );
-----------------------------

---- EXISTING MULTI-COLUMN UNIQUE-INDEX FOR CONSTRAINT: uq_project_app_tenant_and_identifier
  create unique index if not exists
     uq_project_app_tenant_and_identifier
  on
     prj.project
  using btree (
    app_tenant_id,
    identifier
);
-----------------------------

---- EXISTING MULTI-COLUMN UNIQUE-INDEX FOR CONSTRAINT: uq_task_milestone_and_name
  create unique index if not exists
     uq_task_milestone_and_name
  on
     prj.task
  using btree (
    milestone_id,
    name
);
-----------------------------

---- NEW MULTI-COLUMN UNIQUE-INDEX FOR CONSTRAINT: uq_milestone_project_and_name
  create index if not exists 
    idx_prj_milestone_name_project_id
  on 
    prj.milestone
  using btree(
    name,
    project_id
  );
-----------------------------

---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_config_auth ON auth.config_auth USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_token ON auth.token USING btree (id);


---- EXISTING SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_token_user
  create unique index if not exists
     token_app_user_id_key
  on
     auth.token
  using btree (
    app_user_id
);
-----------------------------

---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_permission ON auth.permission USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_app_user ON auth.app_user USING btree (id);


---- EXISTING SINGLE-COLUMN UNIQUE-INDEX FOR CONSTRAINT: app_user_username_key
  create unique index if not exists
     app_user_username_key
  on
     auth.app_user
  using btree (
    username
);
-----------------------------

---- EXISTING SINGLE-COLUMN UNIQUE-INDEX FOR CONSTRAINT: app_user_recovery_email_key
  create unique index if not exists
     app_user_recovery_email_key
  on
     auth.app_user
  using btree (
    recovery_email
);
-----------------------------

---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_app_tenant ON auth.app_tenant USING btree (id);


---- EXISTING SINGLE-COLUMN UNIQUE-INDEX FOR CONSTRAINT: app_tenant_identifier_key
  create unique index if not exists
     app_tenant_identifier_key
  on
     auth.app_tenant
  using btree (
    identifier
);
-----------------------------

---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_contact_app_user ON org.contact_app_user USING btree (id);


---- EXISTING SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_contact_app_user_contact
  create unique index if not exists
     contact_app_user_contact_id_key
  on
     org.contact_app_user
  using btree (
    contact_id
);
-----------------------------

---- EXISTING SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_contact_app_user_app_user
  create unique index if not exists
     contact_app_user_app_user_id_key
  on
     org.contact_app_user
  using btree (
    app_user_id
);
-----------------------------

---- EXISTING SINGLE-COLUMN UNIQUE-INDEX FOR CONSTRAINT: contact_app_user_username_key
  create unique index if not exists
     contact_app_user_username_key
  on
     org.contact_app_user
  using btree (
    username
);
-----------------------------

---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_affiliation ON org.affiliation USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_config_org ON org.config_org USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_affiliation_organization ON org.affiliation_organization USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_affiliation_contact ON org.affiliation_contact USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_facility ON org.facility USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_organization ON org.organization USING btree (id);


---- EXISTING SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_organization_actual_app_tenant
  create unique index if not exists
     organization_actual_app_tenant_id_key
  on
     org.organization
  using btree (
    actual_app_tenant_id
);
-----------------------------

---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_location ON org.location USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_contact ON org.contact USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_evt ON evt.evt USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE INDEX IF NOT EXISTS idx_evt_tx_id_1 ON evt.evt USING btree (external_tx_id);

---- EXISTING GENERAL INDEX: 
CREATE INDEX IF NOT EXISTS idx_evt_tx_id_2 ON evt.evt USING btree (external_tx_id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_evt_type ON evt.evt_type USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_evt_processing_result_type ON evt.evt_processing_result USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_evt_type_subscriber ON evt.evt_type_subscriber USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_evt_ordering_field_type ON evt.evt_ordering_field USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_evt_consumption ON evt.evt_consumption USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_message ON msg.message USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_message_delivery ON msg.message_delivery USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_task_role ON prj.task_role USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_contact_task_role ON prj.contact_task_role USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_task_note ON prj.task_note USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_project ON prj.project USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_project_note ON prj.project_note USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_prj_note ON prj.prj_note USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_milestone_note ON prj.milestone_note USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_task ON prj.task USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_task_dependency ON prj.task_dependency USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_milestone ON prj.milestone USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_milestone_dependency ON prj.milestone_dependency USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_sound_person ON tunz.sound_person USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_venue ON tunz.venue USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_promoter ON tunz.promoter USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_studio ON tunz.studio USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_band_member ON tunz.band_member USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_recording_engineer ON tunz.recording_engineer USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_mixing_engineer ON tunz.mixing_engineer USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_mastering_engineer ON tunz.mastering_engineer USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_studio_session ON tunz.studio_session USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_producer ON tunz.producer USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_instrument ON tunz.instrument USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_musician_instrument ON tunz.musician_instrument USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_show ON tunz.show USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_band ON tunz.band USING btree (id);


---- EXISTING SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_band_organization
  create unique index if not exists
     band_organization_id_key
  on
     tunz.band
  using btree (
    organization_id
);
-----------------------------

---- EXISTING SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_band_repetoire
  create unique index if not exists
     band_repetoire_id_key
  on
     tunz.band
  using btree (
    repetoire_id
);
-----------------------------

---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_booker ON tunz.booker USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_booking ON tunz.booking USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_playlist ON tunz.playlist USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_repetoire ON tunz.repetoire USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_repetoire_song ON tunz.repetoire_song USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_musician ON tunz.musician USING btree (id);


---- EXISTING SINGLE-COLUMN FK-INDEX FOR CONSTRAINT: fk_musician_contact
  create unique index if not exists
     musician_contact_id_key
  on
     tunz.musician
  using btree (
    contact_id
);
-----------------------------

---- EXISTING SINGLE-COLUMN UNIQUE-INDEX FOR CONSTRAINT: musician_repetoire_id_key
  create unique index if not exists
     musician_repetoire_id_key
  on
     tunz.musician
  using btree (
    repetoire_id
);
-----------------------------

---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_musician_track ON tunz.musician_track USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_song ON tunz.song USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_writing_credit ON tunz.writing_credit USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_track ON tunz.track USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_recording_track ON tunz.recording_track USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_recording ON tunz.recording USING btree (id);


---- EXISTING GENERAL INDEX: 
CREATE UNIQUE INDEX IF NOT EXISTS pk_release ON tunz.release USING btree (id);


