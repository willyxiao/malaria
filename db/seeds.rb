schools_hash = [
    {
        name: 'Harvard', 
        communities: [
            { name: 'Eliot House' },
            { name: 'Lowell House' },
            { name: 'Test House' },
            { name: "Dhruv's Housizzle" },
            { name: 'Winthrop House' },
            { name: 'Cabot House' },
            { name: 'School of Public Health' },
            { name: 'Adams House' },
        ],
        admins: [
            'willyxiao@gmail.com',
            'dhruvpillai@college.harvard.edu',
            'mienwang@college.harvard.edu',
            'raynorkuang@college.harvard.edu',
            'xlaguarda@college.harvard.edu',
        ],
    },
    {
        name: 'Northeastern',
        communities: [],
        admins: [],
    },
    {
        name: 'Berkeley',
        communities: [],
        admins: [],
    },
    {
        name: 'Northwestern',
        communities: [
            { name: 'GMB' },
            { name: 'CCHI' },
        ],
        admins: ['angelayang2016@u.northwestern.edu'],
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
            { name: 'MEMO' },
            { name: 'TASC' },
            { name: 'Phi Sigma Rho' }
        ],
        admins: [
            'thsu2012@ucla.edu',
        ],
    },
    {
        name: 'Caltech',
        communities: [
            { name: 'UG Game' }
        ],
        admins: ['anamfija@gmail.com'],
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

malaria_text_facts = [
    "Increased prevention and control measures have led to a 60% reduction in malaria mortality rates globally since 2000.",
    "YET STILL in 2015, there were roughly 214 million malaria cases and an estimated 438 000 malaria deaths.",
    "About 3.2 billion people – nearly half of the world's population – are at risk of malaria. ",
    "Sub-Saharan Africa continues to carry a disproportionately high share of the global malaria burden. In 2015, the region was home to 89% of malaria cases and 91% of malaria deaths.",
    "Malaria is caused by Plasmodium parasites that spread to people through the bites of infected Anopheles mosquito vectors",
    "There are 5 parasite species that cause malaria in humans. Of these, Plasmodium falciparum is the most deadly.",
    "P. falciparum is the most prevalent malaria parasite on the African continent. It is responsible for most malaria-related deaths globally.",
    "P. vivax has a wider distribution than P. falciparum, and predominates in many countries outside of Africa.",
    "70% of all malaria deaths occur in the 0-5 age group. In 2015, 305,000 African children died before their 5th birthdays.",
    "Early diagnosis and prompt treatment of malaria prevents deaths and reduces transmission.",
    "Resistance to artemisinin, the core compound in malaria drugs, has been detected in 5 countries: Cambodia, Laos, Myanmar, Thailand, and Vietnam. However, combination therapies remain effective in all settings.",
    "Insecticide-treated mosquito nets are effective for 2-3 years. They provide personal protection against mosquito bites. From 2000 to 2015, the proportion of children sleeping under an insecticide-treated net in SSA increased from <2% to 68%.",
    "Indoor spraying with insecticide is effective for 3-6 months.",
    "There are more than 400 different species of Anopheles mosquito; around 30 are malaria vectors of major importance",
    "The WHO aims to eliminate P. falciparum in Cambodia and Thailand by 2030, according to the Strategy for Malaria Elimination in the Greater Mekong Subregion (2015–2030).",
    "Every minute, one person dies from malaria.",
    "Ebola killed 11,299 people. In 2015 alone, malaria killed 438,000 people.",
]

malaria_text_facts.each do |text_fact|
    if Malariafact.where(fact_type: Malariafact.fact_types[:text_fact], content: text_fact).count == 0
        puts "Inputting fact: #{text_fact}"
        Malariafact.create(fact_type: :text_fact, content: text_fact)
    end
end

