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
            { name: 'Oak Yard' },
            { name: 'Ivy Yard' },
            { name: 'Elm Yard' },
            { name: 'Crimson Yard' },
            { name: 'Leverett House' },
            { name: 'Mather House' },
        ],
        admins: [
            'willyxiao@gmail.com',
            'dhruvpillai@college.harvard.edu',
            'mienwang@college.harvard.edu',
            'raynorkuang@college.harvard.edu',
            'xlaguarda@college.harvard.edu',
            'hannahsmati@college.harvard.edu',
            'julianarodriguez@college.harvard.edu',
            'cooperbryan@college.harvard.edu',
            'rcuccia@college.harvard.edu',
            'deschler.jack@gmail.com',
            'jamesbrandonjones@college.harvard.edu',
            'alexandramurray@college.harvard.edu',
            'benanandappa@college.harvard.edu',
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
            { name: 'Phi Sigma Rho' },
            { name: 'MedLife' },

        ],
        admins: [
            'thsu2012@ucla.edu', 'yaochang@ucla.edu', 'irg@ucla.edu', 'slee931@ucla.edu',
        ],
    },
    {
        name: 'Caltech',
        communities: [
            { name: 'UG Game' }
        ],
        admins: ['anamfija@gmail.com'],
    },
    {
        name: 'Wellesley',
        communities: [
            { name: 'Wellesley for Public Health' }
        ],
        admins: ['njahan@wellesley.edu']
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

malaria_narratives = [
    {
        name: "Coumba Makalou",
        date: "June 5, 2007",
        location: "Mali",
        link: "http://www.nothingbutnets.net/blogs/what-it-feels-like-to-have-malaria.html",
        quote: "lightning going through my legs, and then spreading through my body and in my head. Probably the worst headache, body aches, and chills you could possibly imagine. It felt like I was being stung repeatedly by an electric shock gun and could barely control my movements. The pain was so intense; I actually believed I was dying",
    },
    {
        name: "Hadia Ali",
        date: "November 11, 2014",
        location: "Comoros",
        link: "http://www.cbsnews.com/news/chinas-test-malaria-drug-artequick-experiment-on-population-of-comoros/",
        quote: "As a mom, malaria is a constant fear. When my baby looks tired, does not want to eat, or behaves strangely, I worry it is malaria. The disease is a nightmare in our lives, especially because I don't have money to take my child to the hospital.... We pray to God that this drug will work, because times are hard and malaria is affecting our families more and more.",
    },
    {
        name: "Romy Rook",
        date: "2012",
        location: "UK/Uganda",
        link: "https://www.malarianomore.org.uk/real-life-stories/romy-rook",
        quote: "Two and half years on, I am well but still feeling the effects and will continue to. Malaria has left my lungs and memory permanently damaged. My eyesight has also been weakened, I am extra sensitive to some lights and have some hearing loss. But at least I have access to the help and support I need from specialists and on-going treatment.",
    },
    {
        name: "Kristine Silvestri",
        date: "June 1, 2010",
        location: "USA/Ghana",
        link: "http://kristof.blogs.nytimes.com/2010/06/01/malaria-a-students-firsthand-account",
        quote: "Days later, when I went for my check-up at the private clinic, my Ghanaian doctor said I was “very lucky.” Lucky to be American, that is. Had I grown up battling other diseases, my body might not have had the strength to beat malaria. At 20 years of age, I was well-fed and athletic, a notable advantage over many Africans my same age with already-compromised immune systems. Through my college courses in international development, I’d become more conscious of the privilege of being white, middle-class, and American. Now I had proof; I was alive because of that privilege.",
    },
    {
        name: "Adou Ouattara",
        date: "June 9, 2015",
        location: "Cote d’Ivoire/Spain",
        link: "http://www.upi.com/Top_News/World-News/2015/06/09/8-year-old-boy-smuggled-to-Spain-in-suitcase-reunites-with-mother/1021433848535/",
        quote: "Adou, an 8-year boy from Ivory Coast, contracted malaria but could not be treated in his country. His father attempted to smuggle him to Spain, where his mother lives, in a carry-on suitcase to receive treatment. Transport authorities found him when the bag went through the x-ray machine. Not only was the boy arrested (while suffering from malaria), but this story highlights the issues of lack of access to treatment and lack of financial means to obtain treatment or leave the country. Bearing witness to the suffering of their loved ones, family members are often driven to take desperate measures."
    }
]

malaria_narratives.each do |narrative|
    narrative = narrative.values
    if not Malariafact.where(fact_type: Malariafact.fact_types[:text_narrative]).map{ |f| f.content[0] }.include?(narrative[0])
        puts "Inputting fact: #{narrative[0]}"
        Malariafact.create(fact_type: :text_narrative, content: narrative)
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
    },
    {
        round: 6,
        question_type: 'multiple_choice',
        question_text: 'How many people die each day from malaria?',
        answers: ['16', '100', '500', '1,600'],
        correct: '1,600',
        correct_text: 'Correct. According to the WHO, an estimated 1,600 people die each day from malaria.',
        incorrect_text: 'Incorrect. Try again.',
    },
    {
        round: 7,
        question_type: 'multiple_choice',
        question_text: 'Which of the following U.S. presidents did NOT contract malaria during his lifetime?',
        answers: ['George Washington', 'Theodore Roosevelt', 'John F. Kennedy', 'Richard Nixon'],
        correct: 'Richard Nixon',
        correct_text: ' Correct. Richard Nixon is the only one of these four to have not suffered from malaria. George Washington, Theodore Roosevelt, and John F. Kennedy all had malaria.',
        incorrect_text: 'Incorrect (this person had malaria!). Try again.',
    },
    {
        round: 8,
        question_type: 'multiple_choice',
        question_text: 'Once malaria parasites enter a person’s blood, which organ do they travel to?',
        answers: ['Liver', 'Stomach', 'Heart', 'Kidneys'],
        correct: 'Liver',
        correct_text: 'Correct. When a human is bitten by a malaria vector, Plasmodium parasites from the mosquito’s salivary glands enter the human’s bloodstream and must travel to the liver within 30 minutes to stay alive. From there, they grow and multiply and infect human red blood cells (RBCs). In just a few hours, the parasites can suck as much as ¼ lb. of hemoglobin from the RBCs of an infected person. This causes severe anemia.',
        incorrect_text: 'No no no no no.',
    },
    {
        round: 9,
        question_type: 'multiple_choice',
        question_text: 'How soon after infection does a person begin to feel ill?',
        answers: ['2 days', '4 days', '6 weeks', 'None of the above'],
        correct: 'None of the above',
        correct_text: 'For most people, symptoms begin 10 days to four weeks after infection, although they may exhibit symptoms as early as 8 days or as late as 1 year.',
        incorrect_text: 'Wrong. Try again.',
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