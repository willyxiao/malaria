def assert(predicate)
    if not predicate
        raise "Assert failure"
    end
end

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
            'hannahsmati@college.harvard.edu',
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

malaria_questions = [
    {
        round: 1,
        question_type: 'multiple_choice',
        question_text: 'Malaria is transmitted by a mosquito bite, but what causes the disease?',
        answers: ['A virus', 'A parasite', 'A chemical in mosquito saliva', 'Blood Poisoning'],
        correct: 'A parasite',
        correct_text: "Correct! Malaria is caused by Plasmodium parasites. Four Plasmodium species cause malaria in humans: P. falciparum, P. vivax, P. malariae, and P. ovale. P. falciparum is responsible for the most deaths. P. vivax is most prevalent around the world.",
        incorrect_text: "Incorrect. Try again."
    },
    {
        round: 2,
        question_type: 'binary',
        question_text: 'True or false: all mosquitoes transmit malaria.',
        correct: false,
        correct_text: 'False: The parasites are spread to people through the bites of infected female Anopheles mosquitoes, called "malaria vectors", which bite mainly between dusk and dawn. ',
        incorrect_text: 'Incorrect. Try again.',
    },
    {
        round: 3,
        question_type: 'multiple_choice',
        question_text: 'Which of the following creatures is the most deadly?',
        answers: ['Shark', 'Mosquito', 'Snake', 'Human'],
        correct: 'Mosquito',
        correct_text: "Correct. Mosquitoes -- despite being the smallest creature on this list -- carry devastating diseases that kill an estimated 725,000 people per year. This far outstrips any other creature on the planet: estimates suggest 50,000 people die from snake bite every year, only 10 die from sharks, and - sadly - around 475,000 by other humans (murders). But that’s still smaller than 725,000.",
        incorrect_text: "Incorrect. Try again."
    }, 
    {
        round: 5,
        question_type: 'multiple_choice',
        question_text: 'The word "malaria" comes from which two medieval Italian words',
        answers: ['Evil insect', 'Biting jaw', 'Bad air', 'Dirty water'],
        correct: 'Bad air',
        correct_text: 'Correct! It comes from mal’aria, the contracted form of the two words mal aria meaning ‘bad air. People originally thought malaria was caused by foul air in marshy areas. We now know that is nonsense and the disease is transmitted by a protozoan parasite that is carried by mosquitoes (in many tropical and subtropical regions that may happen to be marshy!).',
        incorrect_text: 'Incorrect. Try again.',
    }
]

malaria_questions.each do |question|
    if question[:question_type] == 'multiple_choice'
        assert(question[:answers].include?(question[:correct]))
    end
    
    assert(["multiple_choice", "fb_task", "binary"].include?(question[:question_type]))
    
    question = question.values
    
    if not Malariafact.where(fact_type: Malariafact.fact_types[:question]).map{ |q| q.content[0] }.include?(question[0])
        puts "Inputting question: #{question[0]}"
        Malariafact.create(fact_type: :question, content: question)
    end
end