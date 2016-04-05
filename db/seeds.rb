schools_hash = [
    {
        name: 'Harvard', 
        communities: [
            { name: 'Eliot House' },
            { name: 'Test House' },
            { name: "Dhruv's Housizzle" },
            { name: 'Winthrop House' },
        ],
        admins: [
            'willyxiao@gmail.com',
            'dhruvpillai@college.harvard.edu',
        ],
    },
    {
        name: 'Northwestern',
        communities: [],
        admins: [],
    },
    {
        name: 'Berkeley',
        communities: [],
        admins: [],
    },
    {
        name: 'Northeastern',
        communities: [],
        admins: [],
    },
    {
        name: 'Duke',
        communities: [],
        admins: [],
    },
    {
        name: 'Stanford',
        communities: [],
        admins: [],
    },
    {
        name: 'UCLA',
        communities: [ 
            { name: 'MEMO' }
        ],
        admins: [],
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
    
    school_hash[:admins].each do |admin_email|
        if Admin.where(email: admin_email).count == 0
            a = Admin.create(email: admin_email, school: school)
            a.password = Community.random_string()
            a.save!
        else
            puts("Admin exists: " + admin_email)
        end
    end
end

WillyMailer.community_hash_email().deliver_now
