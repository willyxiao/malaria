schools_hash = [
    {
        name: 'Harvard', 
        communities: [
            { name: 'Eliot House' },
            { name: 'Test House' },
        ],
    },
    {
        name: 'Northwestern',
        communities: [],
    },
    {
        name: 'Berkeley',
        communities: [],
    },
    {
        name: 'Northeastern',
        communities: [],
    },
    {
        name: 'Duke',
        communities: [],
    },
    {
        name: 'Stanford',
        communities: [],
    },
    {
        name: 'UCLA',
        communities: [],
    }
]

schools_hash.each do |school_hash|
    school = if School.where({ name: school_hash[:name] }).count == 0
                puts("Create School " + school_hash[:name])
                School.create!({ name: school_hash[:name] })
            else
                puts("School exists " + school_hash[:name])
                School.where({ name: school_hash[:name] }).first
            end
        
    school_hash[:communities].each do |community_hash|
        if Community.where({ name: community_hash[:name] }).count == 0
            Community.create_new(community_hash[:name], school.id)
        else
            puts("Community exists: " + community_hash[:name])
        end
    end

WillyMailer.community_hash_email().deliver_now

end
