//
//  DestinyViewModel.swift
//  Hohoro
//
//  Created by Warit Karnbunjob on 21/2/2568 BE.
//


import Foundation

class DestinyViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var firstNameScore: Int = 0
    @Published var lastNameScore: Int = 0
    @Published var totalScore: Int = 0
    @Published var destinyResult: String = ""
    @Published var showResult: Bool = false
    @Published var isLoading: Bool = false
    
    private let characterScores: [Character: Int] = [
        "A": 1, "I": 1, "J": 1, "Q": 1, "Y": 1,
        "B": 2, "K": 2, "R": 2,
        "C": 3, "G": 3, "L": 3, "S": 3,
        "D": 4, "M": 4, "T": 4,
        "E": 5, "H": 5, "N": 5, "X": 5,
        "U": 6, "V": 6, "W": 6,
        "O": 7, "Z": 7,
        "F": 8, "P": 8
    ]
    
    private let destinyDescriptions: [Int: String] = [
            1: """
            You have high self-confidence because you are influenced by the "Sun". People who are under the influence of this number will be intelligent, brave, brave, have excellent wit, have ambition to be great, dare to take risks, like to be in the front, not second to anyone, think of their own ideas as the most important. Suitable to be a leader, like to be prominent, respected by people in general, have a decisive mind, make decisions quickly, not wavering, sometimes appear arrogant. Life often has to travel all the time. Life will be very successful, famous, have wealth, often do well with their own abilities, be happy, suitable for government work, military, police, executives, company owners.
            """,
            2: """
            "Moon" People who are under the influence of this number tend to be highly imaginative, optimistic, kind-hearted, and generous, making them easily loved by others. However, their minds tend to be sensitive, sometimes overthinking, daydreaming, and building castles in the air. They easily follow others, like poetry and aesthetics, and enjoy a free life. Number 2 people may seem sensitive at first glance, but when it comes to a crisis, they can control their wits well. They are incredibly brave and strong. They are suitable for jobs that require creativity, such as poets, architects, designers, art directors, artists, etc.
            """,
            3: """
            "Mars" is the star of bravery. People who are under the influence of this number tend to like fighting, like war, sometimes stubborn, self-willed, but still diligent to achieve their own goals, not easily giving up. Mars is truly considered the lord of war, whether it is work or love. In terms of work, you tend to like the type of work that requires competing for customers, bidding to get work, opening a business that requires a lot of competition, which will please you a lot. In terms of love, you like to be the hunter rather than being courted. If you win, you will be very proud because you are someone who does not like anything that comes easily. But in terms of love, there are often problems because you are someone who does not give in to others, so you often have arguments with your lover.
            """,
            4: """
            "Mercury" People who are under the influence of this number often have intelligence, wit, high agility, understanding of people, like to socialize, excellent human relations, can get along with anyone, and everyone wants to be close to them. They have the art of persuading people's minds, like to speak, like to talk, but sometimes can be unstable, indecisive. Suitable for public relations work, marketing, artists, debaters, work that requires customer contact, sales of all types.
            """,
            5: """
            "Jupiter" is the number of wisdom. People who are under the influence of this number are virtuous, have ethics leading their hearts, like to learn constantly, have calmness and carefulness, love justice, do not hurt and take advantage of others. They are studious, love to seek knowledge all the time, have high education, can graduate with a doctorate if desired. They often solve problems with mindfulness rather than using force. Others can hardly persuade their minds. Number 5 people often like religion, sacred things, are optimistic, like solitude, sometimes too honest and pure. Suitable careers are teachers, rulers, scientists, researchers, monks, religious teachers.
            """,
            6: """
            "Venus" is the star of art, aesthetics, love, and enchanting charm. People who are under the influence of this number often achieve beautiful success, have charming allure, love beauty as their life and soul, have taste in dressing, often use luxurious expensive things. They love art and music, entertainment, love comfort, don't like work that requires labor. In addition, they also have wealth, various assets. Suitable work includes actors, performers, models, beauty queens, musicians, makeup artists, beauty spa owners, beauty equipment sales, flower sales, cosmetics sales, public relations, design, architecture would be fitting.
            """,
            7: """
            "Saturn" is a symbol of patience, sorrow, and prolonged situations. People who are under the influence of this number often suffer hardship and are orphaned since childhood, have chronic illnesses, are stubborn, have their own opinions, others can hardly persuade them. Whatever they do often faces obstacles, nothing comes easily, must always go through long periods of effort and patience. They are not settled, love affairs are often unsuccessful, often have to separate, not often together as a family. But the good point is they are highly patient, not easily discouraged, calm, always think before making decisions. Suitable careers are those related to agriculture, animal husbandry, real estate, land broker.
            """,
            8: """
            "Rahu" is a sign of delusion and intoxication. People who are under the influence of this number often face false accusations, are easily led astray, like gambling, all vices, like nightlife. Love and work face obstacles, face bullying, easily angered, constantly irritated. They like all kinds of gambling, like to compete, especially in matters of love - when in love, they must possess what they desire. But the good point is they often have opportunities to travel abroad, like to associate with foreigners of different languages, are generous, loyal to friends to the end, don't hold grudges, quick to anger but quick to calm. Suitable for all types of night work, owners of pubs, bars, massage parlors, photographers, import-export of foreign goods.
            """,
            9: """
            "Ketu" is the number of miracles. People who are under the influence of this number often have accurate intuition, have sacred protection, often escape from accidents, are devoted to mystical sciences, interested in antiques. Ketu is a star that protects from harm, both in terms of prison and accidents, and also helps ensure long life, progress in life, and good well-being.
            """,
            10: """
            You often experience difficulties in life. Whatever you think of doing, you often encounter competitors, have people who wish you harm, have many enemies. If you have your own business, you often don't get along with employees because of your dictatorship. Subordinates or younger people often bring obstacles and problems. Whether life will be successful or fail often depends on your decision-making in choosing your life path.
            """,
            11: """
            You are a person with very high self-confidence and strong leadership qualities. You don't like to follow others' thoughts, sometimes to the point of being self-absorbed. Rather stubborn, hot-tempered, quick to make decisions, not very careful, which may lead to problems in the future. You love freedom and don't like being bound to anyone. Once you set your mind on something, it's hard to change. May have problems with subordinates because you tend to be quite dictatorial. When facing problems, you don't like compromise because you won't accept losing face or dignity at all.
            """,
            12: """
            Consider yourself important, highly confident, quick to decide, willing to sacrifice even your own life for others. If in high positions, beware that life may rise and fall quickly, hard to find stability. When involved with others, often face false accusations from others. Should be careful of unexpected accidents. Will be cheated, face financial problems, others cause trouble, lose power.
            """,
            13: """
            Good and bad things tend to happen suddenly - bringing both benefits and harm quickly. May face danger from unexpected accidents, easily get into arguments with people around due to being hot-tempered and unyielding, often acting on emotions. You tend to have different opinions from others, sometimes like to stand out in unusual ways, brave without fear of anyone, which often leads to danger in the end. Must be careful about accidents, surgery, being harmed by weapons, having conflicts with partners or close ones, family problems, lack of support from seniors, affairs. Life that's prosperous can suddenly turn bad unexpectedly. Considered more negative than positive.
            """,
            14: """
            A very good number, often bringing stable prosperity and success in life because of good partners and planners. You like to study various subjects and can apply or build upon that knowledge. You're intelligent, able to memorize things accurately and quickly, have the art of communication with others, good at solving immediate problems, dare to think and act, dare to decide. Famous due to your own knowledge and abilities, good wit, good at problem-solving, using intelligence to solve problems. Successful in love, getting a good partner with good intelligence, helping each other think and do things to achieve success.
            """,
            15: """
            This is a number of finance, enhancing luck and bringing large sums of money continuously, receiving fortune easily. A very good number. You are a lucky person, whatever you do, there are people helping and supporting you. Life doesn't require much struggle, always have senior people's support, never falling down. You are charming, good-tempered, intelligent, virtuous, smart in making money, good financial status, life is prosperous. When needing to decide to solve conflicts, you will use wisdom-based solutions, based on justice and everyone's benefit. This makes you respected by people around you. Have excellent wit, learn and remember things quickly, can study to high levels as desired. Good-natured, can get along with people at all levels, good at reading people, often receive rewards both in things and money from others, compassionate, like making merit.
            """,
            16: """
            You love beauty and take good care of yourself because you believe that appearance matters. You like dining in restaurants with good atmosphere, like beautiful things, all kinds of fragrances, like socializing, love fun. You're not good at planning money usage, like to spend lavishly, can't save money, often spend money on self-indulgence. Have charm with the opposite sex but tend toward being flirtatious. Without self-control in this matter, life will face problems. If you fall in love, you might become obsessed, affecting work. Life will find dramatic success, have fame, power, followers, great influence in unexpected ways. But beware of unexpected problems as well, might be betrayed by close ones. Sometimes before finding success, must overcome numerous obstacles.
            """,
            17: """
            You are a person with inherent power, often respected by others, but life often encounters obstacles and difficulties. When doing business, often must work hard before achieving success. You trust people easily, partners or business partners might make wrong decisions causing debt. This leads to overinvestment because debt may occur. Working with partners isn't good, doing things by yourself would be better because conflicts may arise. For ladies, often have problems with relationships, unfortunate in love, late marriage or no partner, often disappointed and heartbroken in love matters continuously.
            """,
            18: """
            You are hot-tempered, often act based on your emotions, not very reasonable. You think big, often do things beyond your capacity, good at solving immediate problems, know how to be flexible, suitable for not-so-transparent business, you will do well. Can be called a turning point destiny, if good will be very good, but if lost will be hard to recover. In business shouldn't be hasty because it will put you at a disadvantage to competitors. Therefore should think carefully before deciding to act. Life often encounters unexpected things, being pressured and threatened by those in power, targeted by enemies.
            """,
            19: """
            A very good number, often achieving unexpected success, tends to have power and status, holds rank and position, respected and feared by others, lucky. You have special abilities, unique and innovative thinking, and can apply that thinking for practical use. Receive patronage from seniors or those in power for protection, often escape from all dangers unexpectedly, have sacred protection. If danger will occur, there are omens warning in advance. Considered a lucky number, will bring good results for future great success.
            """,
            20: """
            You are a person with wide imagination, like creating new things, always have new ideas in mind, have progressive modern thinking. If actually implementing, will be a thinker and can invent until successful. Like reform and change, don't like staying still, have great ambition and enthusiasm. Like seeking new ways to solve problems, don't like staying in one place, dare to take risks and try, believe that what you do must succeed. Life will be very successful because of your own creativity, often have accurate intuition.
            """,
            21: """
                You are a person with gentleness and emotional sensitivity, but at the same time, possess hidden pride, self-importance, and self-centeredness. You have decisiveness and determination. You have a spouse who provides good support. What needs to be careful about is your mental state, because you are emotionally sensitive - if someone speaks unkindly, you tend to dwell on it, easily feel hurt, and often have hidden sadness deep in your heart.
                """,
                22: """
                You have a gentle heart, like to create new things, always have initiative thoughts, like to daydream, are emotionally sensitive, have a merciful heart, are compassionate, like making merit, take good care of people around you, have charm with people in general. But the downside is you're gullible and trust people easily, so you often get deceived. Your mind wavers and isn't firm - if someone objects, you might easily change your mind. Indecisive, overthinking, keep everything to think about, making you often troubled. You're more of a thinker and dreamer than a doer, like building castles in the air. Success is therefore difficult because you have ideas but don't implement them. You'll do well in work related to creativity, such as art, public relations, creative work, poetry, artistry, service-related work.
                """,
                23: """
                You are polite and gentle, friendly with everyone, have a merciful heart, emotionally sensitive, have charm that captivates those who meet you. This is a good number with charm, having influential seniors providing support, promoting life to achieve great success.
                """,
                24: """
                A very good number. You have strong charm, many friends, good-natured, easily get along with others. Friends often provide good support, whatever you think of doing, people often come to help you succeed. Have gentle manners, making you beloved by people in general. Have the art of speaking, good taste in dressing, dignified. You're quick-witted and intelligent, good at handling immediate situations. Life often succeeds in all aspects, whether work or love. You're far-sighted, quickly understand your surroundings, are detailed and thorough, not superficial in understanding art, don't like showing power. Family life is happy, wealthy and stable, and fortune regularly comes. Suitable for almost all careers, especially jobs requiring negotiation skills, such as public relations, flight attendant, sales, actor, model, business owner, businessman, artist.
                """,
                25: """
                You will have stability in life, have senior support and help, good intelligence, studious, high knowledge and ability, love justice, smart and witty, while also being gentle and sweet. Success will certainly await you. You will get a good, outstanding partner, famous and well-known in society. Your spouse will be well-established with high knowledge, but there will be quarrels with your spouse. Must suffer in matters of love, love is often unfulfilled, events always cause separation from loved ones. If female, beware of losing reputation before marriage.
                """,
                26: """
                You are a charming person, have a full face, charming to those who meet you, have a merciful heart, gifted in arts, dreamy, emotionally sensitive, have gentle manners, love orderliness, making you attractive to others. You have high taste, good personality, fresh love. On the negative side, life can easily be led astray, be deceived to lose assets, be careful in associating with others, must consider relationships carefully because they might bring damage.
                """,
                27: """
                Life often achieves success due to determination, perseverance, and diligence through your own efforts. You are careful and patient, have high self-confidence, are a good manager, highly independent. It's quite difficult for others to change your thoughts or persuade your mind. Like to invent new things, have unique innovative thoughts. On the negative side, life often encounters stress and mental suffering. Life is often busy with creating various rules to define life according to goals, resulting in stress and not having as much happiness in life as should be. Looking sad like someone carrying suffering all the time, not fresh and bright, lacking supporters. As for love, it's often unfulfilled, usually having bitter love, marrying someone you don't love, or having reasons to separate from loved ones frequently. If calculated to get this number, should change name or surname quickly.
                """,
                28: """
                This is a number that brings more negative than positive effects to life. Life is often difficult since childhood, often having mental suffering, bitterness, constant disappointment. If male, often disappointed in love. A person with little responsibility, easily bored, daring to gain and lose, large works often don't succeed because of insufficient patience. Like to do things based on emotions which might lead to bad results. Not suitable for business investments requiring loans because there's a chance of not succeeding, or lending money to acquaintances because there's little chance of getting it back. Like taking risks in foreign places, will get a foreign partner, have opportunities to live or spend life abroad. A person with self-confidence but doesn't trust others, so life is full of conflicts and competition.
                """,
                29: """
                People under the influence of this number tend to be charming to the opposite sex, have gentle and merciful hearts, are compassionate, emotionally sensitive, uniquely beautiful, have mysterious charm, have sacred protection, often escape accidents unexpectedly. Have creative thinking, like to invent new things, like service, helping disadvantaged people. Have opportunities to live abroad or have a foreign spouse. On the negative side, being emotionally sensitive makes it easy to be mentally affected, overthinking, repressed, often pressured by people around, having hidden suffering.
                """,
                30: """
                Can result in dramatic prosperity, but at the same time, prosperity might suddenly collapse unexpectedly. Physical health isn't very good, often getting sudden illness or accidents causing danger. Should be very careful about accidents because the accident aspect is quite severe, surgery and sudden serious events. When having opportunities to succeed in work duties or love, there often are events that make you easily miss important positions. Have high volatility, smooth things will have obstacles blocking them, prosperity isn't sustainable.
                """,
            31: """
            Considered an inauspicious number. People under the influence of this number often encounter unexpected serious accidents, surgery, poor health, sudden illness. Life often breaks in the middle, will experience strongly emotional events in life, have scandals in love, unstable married life, often don't get along with colleagues or close people. But there are some good aspects: life often starts with bad luck but achieves success in the end, must overcome many obstacles before succeeding. If the sum of name or surname equals this number, should change quickly.
            """,
            32: """
            A good number. People under the influence of this number often excel in matters of spouse and the opposite sex greatly. Have strong charm, attract the opposite sex, always have people coming to love and like them, can attract attention from the opposite sex very well. If female, it's said the house stairs never dry (meaning many suitors). Seniors will be fond of and give merciful support, love studying and seeking knowledge.
            """,
            33: """
            People under the influence of this number often have intense emotions, quick to anger, not calm and careful, lack patience, like to do things their own way, have no self-restraint, stubbornly persistent like a head hitting wall. Number 3 is an accident star and there are two of them, must beware of sudden unexpected dangers, often meet with accidents, must have surgery, often face dangers related to speed or sudden illnesses. Must be careful of conflicts and quarrels. A person who has strong desires in love emotions, passionate and intense, if they like or love someone, must compete to possess them.
            """,
            34: """
            People under the influence of this number are intellectually brilliant, always like to study and seek knowledge, have quick wit, have the art of speaking and persuading others' minds, brave, dare to speak and act, are open, have patience and endurance. But the downside is often being hot-tempered, stubborn, not listening to anyone. Although life may encounter many obstacles, they can always survive with their own intelligence, will achieve success through their own efforts. In childhood, people with number 34 often experience accidents and injuries from fangs and claws, must be very careful about neurological and brain system diseases.
            """,
            35: """
            People under the influence of this number often have decisive thoughts, are brave, seriously determined, versatile in work around them, have natural talent, can get along with people of all levels. Later life will experience good success, will have senior support, get to work with foreigners or have opportunities to live abroad. Childhood life often orphaned or not living with parents, have health problems, have undisclosed love. People with this number must be careful of being misled, being deceived because of trusting people easily, which will cause harm to themselves later. Suitable careers include military, police, government service, work related to foreigners, export business.
            """,
            36: """
            A very good number. People under the influence of this number will experience great success in life, have many friends, have charm with the opposite sex, have supporters and won't fall down. Love and relationship matters are fresh, the opposite sex often gives good warmth. Good family foundation, warm, have spouse, have stable evidence, have good knowledge and ability, hardworking, have mutual support and harmony, have fame, have life's freshness, can find money easily, have money to use without shortage. Can do almost any profession, especially careers that require communicating with others, will receive good help, such as public relations customer contact, sales representatives, business owners, executives, actors, performers, artists.
            """,
            37: """
            Considered a bad number. People under the influence of this number are brave but often self-centered, consider themselves important, stubborn. Life constantly encounters obstacles, lacks senior support. If involved with anyone, beware of quarrels, followers or partners often betray due to conflicts. Face severe disasters and terrible diseases, tormented by surgery. Beware of chronic illnesses and accidents, rapid and severe damage. Poor physical health, constantly having legal issues, life has turning points all the time, often unstable, not very smooth. If name or surname calculation results in this number, should change urgently.
            """,
            38: """
            A bad number. People under the influence of this number often are dominated by delusion and obsession, like to use force to solve problems, like to act important, moody, often face severe volatility in life. Life often has only chaos, have friends who lead them astray, like to associate with thugs and gangsters, become infatuated with bad things, make dishonest living. In love matters, often obsessed and intoxicated with desires and lust, if love or like someone must compete to possess them. Number 38 people must be careful about spirits and local deities as it can be quite intense.
            """,
            39: """
            People under the influence of this number have a brave personality, dare to speak and act, speak straightforwardly and bluntly, often are diligent, have many friends, and close friends will provide good support. But hot-tempered, rash, if want something must possess it, don't really listen to others, so often encounter difficulties in life and have strongly emotional impacts which might easily lead to instability. Also beware of third parties interfering in life.
            """,
            40: """
            A good number. People under the influence of this number are intelligent and clever, have excellent wit, good at solving immediate problems, have the art of persuading others' minds, like to invent new things, have far-reaching imagination, like mysterious and miraculous things, like to create surprises for society always, often like traveling. Will experience success in marketing and all aspects of business. Suitable for work that requires communicating with many people, such as public relations, scientists, technicians, engineers, various business owners.
            """,
            41: """
                A very good number. People under the influence of this number often experience great success in life, have excellent wit, dare to speak, quick intelligence, brilliant mind since childhood. Seniors often provide support throughout life. They love to constantly study and seek knowledge, have excellent memory, get along well with friends, love compromise, but will hide their ambitious dreaming nature from others. Suitable careers include teachers, professors, researchers, debaters, speakers, hosts, company owners, sales representatives.
                """,
                42: """
                A very good number. People under the influence of this number often have gentle, polite, soft, romantic personalities, have charm, whoever sees them loves and wants to be near them. Sharp intelligence, have the art of communication, good at persuading others, high psychology, easily get along with others, have many friends, often beloved by all people. Eager to learn, life will experience great success, famous and well-known in society. Lucky in work and financial matters, can earn easily. Like arts, poetry, have delicate minds, often successful in life, never fall down. Suitable for all types of careers.
                """,
                43: """
                People under the influence of this number have personalities that easily get along with others, have wit, good at solving problems, but overthink things, don't trust others easily, have enemies plotting behind their backs all the time. Future life often encounters failures, difficulties, and suffering throughout. Life will face only obstacles, suffering, disappointment and failure, have hidden sadness inside, smiling face but aching heart. Must not be careless at all. During teenage years might easily encounter accidents. Love is unfulfilled, late marriage.
                """,
                44: """
                People under the influence of this number often like to study and seek knowledge, have excellent intelligence, are well-known in society, love reading as a habit, are good speakers, good at persuading people, high psychology, easily get along with others. Have supporters helping throughout, never fall down, have moderate success in life. But beware of being deceived because of trusting people easily. Be careful in choosing friends because they might lead you astray. Suitable careers include speakers, debaters, sales representatives.
                """,
                45: """
                Another very good number, enhancing fortune and bringing large sums of money continuously, receiving fortune easily. People under the influence of this number often have wit and sharp intelligence, will succeed in studying all subjects, have charm in their words, understand people, can adapt to society anywhere. Experience stable success in both work and love. Whatever they do, seniors often help throughout, never fall down. These people have sharp intelligence, know both worldly and spiritual knowledge, have sacred protection, often escape from serious accidents. Whatever they do receives cooperation from people of all levels and often succeeds unexpectedly. Suitable for all careers, especially those requiring the art of communication.
                """,
                46: """
                A good number. People under the influence of this number tend to be successful in life, business and trading brings good profit because they know many friends, and friends provide good support and patronage. Smart, witty, have excellent intelligence, eager to learn, good at solving immediate problems. Will have happiness in marriage, good at making money.
                """,
                47: """
                People under the influence of this number are often soft-hearted, wavering, and trust people easily. Have highly independent thoughts, difficult for others to change or persuade their minds. But must beware of being misled, which will destroy their bright future. Often achieve success through exhausting effort, but before reaching goals must use much patience and effort, because the influence of number 7 results in life often having hidden bitterness and suffering.
                """,
                48: """
                A number that brings more harm than benefit. People under the influence of this number can get along with people of all levels, have the art of speech, good at negotiating, but wavering and indecisive. Warning point is don't trust others easily, because you are naturally soft-hearted and compassionate, you will be easily led and sweet-talked. Should use wisdom in choosing friends because you might be led to use your intelligence for unethical things. Should be careful of life, will encounter accidents, often have illnesses afflicting them and suffer from terrible diseases.
                """,
                49: """
                People under the influence of this number should beware of severe damage that will occur. Married life is uncertain, family breaks apart, has turning points in life. Ladies often face harassment from husbands. Life has bitterness and disappointment, whatever they do often has obstacles blocking the way, unlucky.
                """,
                50: """
                A very good number, enhancing fortune and bringing large sums of money continuously, and receiving fortune easily. "Jupiter" represents intelligence. People under the influence of this number tend to be virtuous, have excellent intelligence, good memory, clever, honest and straightforward, kind-hearted, can solve problems with wisdom. Have high chances of success in life and succeed well in financial matters. Have opportunities to study as high as desired. The death star makes them like traveling abroad and have sacred protection, have luck in foreign lands. If doing business related to foreigners will prosper, or might get to study, associate with foreigners. Like to research, study dharma, are people who believe in nature's mysteries and have intuition with sacred things. Suitable careers include jobs requiring frequent travel abroad such as flight attendants, import-export business people, diplomats.
                """,
            51: """
                A very good number, a number of finance, enhancing fortune and bringing large sums of money continuously, receiving fortune easily. People under the influence of this number tend to be virtuous, have outstanding academic knowledge and ability, clever, have deep intelligence. Have opportunities to succeed in both work duties and high education. A person with all-round abilities, making them widely respected, and always have followers helping. Have many friends, successful in love, often get good partners. Have mature thinking, reasonable, can be good speakers because they're good at persuading people. Have artistic talent, love beauty, always optimistic. Often receive rewards both in things and money from others. Suitable careers are those related to art, all kinds of beauty, speaking, writing, entertainment, will be very progressive.
                """,
                52: """
                People under the influence of this number often receive good success in life. Saturn makes them serious about life, have good patience, will succeed through their own efforts, will receive good support from others. Jupiter represents virtue and knowledge, can learn things quickly and deeply, can study as high as desired. If male will have Venus's support, if female will get a good husband.
                """,
                53: """
                A number giving moderate benefits, having both good and bad alternately. People under the influence of this number often have decisive thoughts, determined seriousness, dare to decide, have high perseverance, have stability in life, have senior support always. But being gullible and easily trusting people, easily becoming infatuated with things, so others often deceive them. If in bad environments, often get taken advantage of, get credit stolen. Life's failures will come from friends and partners, will have love triangle problems, often have secret love.
                """,
                54: """
                A number of finance, enhancing fortune and bringing large sums of money continuously, receiving fortune easily. Indicates success in life. People under this number's influence tend to be virtuous, have sharp intelligence, have wit in solving immediate problems, calm and careful, like solving problems with wisdom, making people trust and believe in them greatly. Seniors always provide support, will receive large fortune from all forms of risk-taking, lucky success, have stability in life, life is often lucky, receive protection from sacred things, often escape from serious accidents unexpectedly, few obstacles in life.
                """,
                55: """
                A very good number, enhancing fortune and bringing large sums of money continuously, receiving fortune easily. People under the influence of this number often have stable life progress, experience excellent success in life, have big work positions, always have seniors showing affection. Have fairness and love virtue and goodness, are respected by people in general, devoted to sacred things, love peace, like traveling far, have opportunities to work or study abroad. Get intelligent and virtuous spouses, have very high chances of success in life, and succeed well in financial matters.
                """,
                56: """
                A very good number, a number of finance, enhancing fortune and bringing large sums of money continuously, receiving fortune easily. People under the influence of this number are smart, have excellent intelligence, have virtue in their hearts, have all-round abilities whether in academics or arts, have deep thinking, work well, strong mind, not discouraged by obstacles, have charm with the opposite sex. Life will succeed very well, both in family and assets, wealthy status, famous, respected in society, have seniors loving and supporting always.
                """,
                57: """
                People under the influence of this number often have strong internal conflicts. The good point is they have virtue leading their hearts, good intelligence, learn things quickly, but the downside is they're quite stubborn, self-willed, don't like compromise, making them have many enemies. Achieving success in anything is quite difficult, must always go through exhaustion and obstacles first. Often orphaned from parents since young, often become infatuated with things, self-absorbed, often don't trust others.
                """,
                58: """
                People under the influence of this number are intelligent but often misled, seeing wrong as right, when infatuated with something tend to be obsessed until can't withdraw. Have unique strange thoughts, fitting the pattern of good beginning but bad ending. Have stubborn habits, like to oppose religion, mind tends toward heresy or mistaken in rituals rather than the true essence of dharma. In the end will meet with bad karma.
                """,
                59: """
                A very good number, a number of finance, enhancing fortune and bringing large sums of money continuously, receiving fortune easily. People under the influence of this number have excellent intelligence, kind-hearted, honest, love justice, have virtue in their hearts, have charisma respected by people in general. Have seniors always supporting well, are people who hold firm to sacred things, seniors and sacred things always help, believe in religion, interested in mystical sciences, have sacred protection, often narrowly escape from serious accidents, have excellent intuition. If working related to foreigners or online will prosper very well.
                """,
                60: """
                People under the influence of number 60 often like art, love beauty, like socializing, have high imagination, aesthetic emotions, like luxurious living, optimistic, romantic, have wit, good at problem-solving, get along well with people, are up-to-date with people. Suitable for business related to beautiful things or finance.
                """,
                61: """
                People under the influence of this number often have dual emotions with internal conflicts. Their outer personality is social, loves beauty, likes art, emotionally sensitive, hot-tempered, loves honor and dignity. Sometimes tend to let themselves get carried away with worldly temptations, but sometimes love solitude, like to act like someone carrying suffering. Often have illnesses afflicting them, in life often have easy turning points, too proud of themselves until people dislike them and they're not accepted in society.
                """,
                62: """
                People under the influence of this number, on the good side, tend to have delicate minds and sensitive emotions, high mercy, especially love beauty, have charm with the opposite sex, have many friends and people always helping support. On the bad side, tend to be easily misled and deluded, beware in choosing friends as they might lead astray, like to let themselves drift along, which leads destiny toward disaster in the end. If male, often favored by the opposite sex.
                """,
                63: """
                A very good number. People under the influence of this number often have strong charm, lucky in love, always have people coming to love them, sweet love, high chances of marriage. Are delicate people, enchanting, proper manners, can always create impressions on people around them. Life will experience excellent success in both work and love. Can advance at work, have big positions, have many friends, especially the opposite sex often provides help. Can become wealthy, good at finding wealth, if doing business will prosper.
                """,
                64: """
                A very good number, a pair of stars giving many benefits. People under the influence of this number have charm, good taste, excellent wit and intelligence, good intelligence, can memorize and learn things accurately and quickly, clever with people, good at persuading hearts, can get along with all types of people. Often have fulfilled happiness in life, prosper in business, don't like staying still, like seeking new things, have special artistic ability. Suitable for all types of work, especially work requiring communication with others, work related to image such as actors, performers, politicians, business owners, businesspeople.
                """,
                65: """
                A number of finance, enhancing fortune and bringing large sums of money continuously, receiving fortune easily. People under the influence of this number tend to have excellent intelligence, have virtue in their hearts, are respected by people in general, have well-rounded knowledge in both academics and arts. Sometimes their outer personality appears gentle but inside is strong. Life will experience excellent success in both work and love, will be wealthy in assets and money, and receive support from important seniors well or have seniors helping secretly. Have opportunities to advance in work duties to highest positions. Are dreamers and enchanted with art. People under number 65's influence will always have people coming to help.
                """,
                66: """
                One of the dangerous numbers. People under the influence of this number, when they love something will love obsessively, because they don't carefully consider things thoroughly. When they love something they tend to throw their whole self into it. Are people intoxicated with worldly matters, extravagant at spending money, often spending on entertainment and affairs. The end of life often encounters suffering, unsolvable problems, and might end life with bad matters.
                """,
                67: """
                A number of disappointment in love. People under the influence of this number often have problems with love, often get deceived, get betrayed in love matters always, have suffering and bitterness in love, unfulfilled in love. Even though they get married, they often don't get to live together, have matters that make them separate forever. Have obstacles in life, family breaks apart, beware of unexpected accidents. At the end of life might end life with problems related to love.
                """,
                68: """
                People under the influence of this number tend to be easily infatuated with things without careful consideration first, especially being intoxicated in love matters, enchanted with vices, obsessed with black magic, often like to make themselves stand out from others. People of this number tend to be extravagant because they're enchanted with beautiful expensive things, self-absorbed, often like to make themselves prominent and stubborn in wrong ways.
                """,
                69: """
                People under the influence of this number, if female will be gentle, polite and proper, sweet, love comfort, sensitive. For males, will be romantic, have artistic mind, sweet-talking, good at sweet talk, have mysterious charm, always have sacred protection, have good creative thinking, have good taste in dressing. Finance is outstanding, suitable for business related to foreign countries.
                """,
                70: """
                A truly number of sorrow. People under the influence of this number tend to be always anxious, obsessive-compulsive, face carrying suffering, not bright, vengeful, vindictive, pessimistic. Life often falls into suffering always, often unfairly pressured, face legal cases in court, get secretly harmed, have severe illnesses, both sudden and chronic, neurological disease. If name or surname sum equals this number, should change quickly.
                """,
            71: """
            A number of disaster. People under the influence of this number often face power limitations, pressured to fall from positions, face false accusations, betrayal, imprisonment. Love often has divorce problems, often get lost in wrong ways, mind easily strays toward vices, thus making it difficult to achieve success in life.
            """,
            72: """
            People under the influence of this number often experience suffering and bitterness from spouses, have divorce, even when married to someone they love often have reasons to separate, get deceived, get betrayed. Although destiny is strong and prosperous, life will be chaotic, often facing bad luck. Beware of chronic illnesses. On the good side, often escape from serious accidents.
            """,
            73: """
            A number of accidents, causing people under its influence to often encounter accidents or sudden surgery. Life will turn midway, face bankruptcy, have debt. Whatever they do will have obstacles blocking success. Often have incurable chronic diseases, get arrested and prosecuted, suffer physical harm. Life has a bad ending. If name and surname sum equals this number, should change quickly.
            """,
            74: """
            A good pair of element stars, thus a fairly good number. People under its influence will find moderate success in life, have perseverance and patience in working to achieve goals. But to achieve progressive success must reduce anxiety and emotional instability. Regular prayer and meditation will strengthen the mind.
            """,
            75: """
            People under this number's influence tend to be exhausted in early life because they have high perseverance and patience, not discouraged by life's obstacles. Life at the beginning often must fight much before achieving success, but the end of life will be very prosperous, have seniors helping and supporting well. Called a life with bad beginning but good ending.
            """,
            76: """
            People under this number's influence often must suffer in matters of love, separate from loved ones, life often gloomy, get deceived, family breaks apart, unhappy, get flawed partners. Especially in married life often divorced or widowed. Beware of quarrels with partners or colleagues too.
            """,
            77: """
            People under this number's influence will experience suffering in life, encounter only bad fate, face double intensity of violence, have illnesses afflicting like neurological disease, stress. Before achieving success in each matter must use much effort. Often taken advantage of by close ones. However, these people often have more strength and endurance than others. People give them good respect, have power, make people fear, those who think ill of them will defeat themselves.
            """,
            78: """
            People under this number's influence often suffer bitterness, encounter only bad stories, might get neurological disease or stress. Have constant pressure in life, carry many burdens. Beware of accidents and getting lost in bad things. Have legal cases, get betrayed, slandered. Often easily led astray by others, so don't be gullible and trust people easily, which might bring disaster to life in the end.
            """,
            79: """
            People under this number's influence have exhausting early life but will achieve success in later life. Are people who must carry many burdens, often worry about old matters or have chronic illnesses. But on the good side will have sacred protection, people who think ill of them often defeat themselves. Will receive antique inheritance, know how to save, life will achieve dramatic success.
            """,
            80: """
            Considered a bad number, with influence from Rahu star 8 and Death star. People under this number's influence often encounter evil things, have hardship and suffering, often encounter obstacles, get dominated and oppressed by gangsters, often fall into bad environments, get obsessed with black magic or vices. For women, might face rape or threats from gangsters.
            """,
            81: """
            People under this number's influence often live as orphans, lack support, life must move frequently whether in work duties or residence, separate from parents. If female beware of being widowed without partner or separation. Will have eye-related illnesses. But sometimes frequent changes make life turn prosperous.
            """,
            82: """
            People under this number's influence often orphaned, without support, lack life security, have lonely depressed life, often face mental pressure, have people stealing credit, must carry many burdens. Life often drifts along with fate, have terrible diseases that can't be cured. If male will be without partner or get flawed partner. Beware of getting lost in bad things which might lead life to disaster in the end.
            """,
            83: """
            People under this number's influence often encounter only quarrels, accident surgery, court cases, often have events causing breakage and damage. Beware of fire and dangers from crowds. Be careful of getting lost in bad things, often threatened by gangsters, gullible and trust people easily. The end will meet with bad karma.
            """,
            84: """
            People under this number's influence during teenage years often misbehave because of getting lost in bad things, partly from choosing wrong friends, causing trouble and great loss. Experience severe bad fate, get injured from accidents, get bullied by others, lack helpers in times of trouble, have lawsuit cases, get hated, poor health, love is not smooth and unfulfilled.
            """,
            85: """
            People under this number's influence have the good point of being clever, can learn things quickly, but often use intelligence in wrong ways, often see wrong as right, lose reputation, orphaned from parents, intoxicated in love. Life often drifts because of being lost in wrong things which will lead life to disaster in the end.
            """,
            86: """
            A number strong in both good and bad aspects. People under its influence, on the good side will achieve success in life, have money, wealthy, have charm with opposite sex. But on the bad side, often get intoxicated in desires, especially in love matters, like having affairs, never knowing enough, lost in vices, self-centered.
            """,
            87: """
            A number of bad karma. People under its influence often have charm, easily emotional, moody, carrying suffering, often misguided, gullible, trust people easily because lacking firmness, always make wrong decisions. Have many friends but hard to find sincere ones. Beware in choosing friends because might be led astray. Have violent thoughts, like solving problems with emotions, aimless in life. Later life often declines.
            """,
            88: """
            A bad number. People under its influence often find dramatic success, to achieve anything must face many obstacles. Are skilled in all aspects, thus becoming self-absorbed, highly ambitious, self-centered, unsympathetic to others, often easily see wrong as right, won't listen to anyone's warnings. Life must beware of accidents, abnormal death.
            """,
            89: """
            People under this number's influence are often clever, have sharp intelligence up to date with people, quick-minded, have clever thoughts, good at solving immediate problems, have high ambition, can enter any social level, well-liked in society, often devoted to mystical sciences.
            """,
            90: """
            People under this number's influence are like cats with nine lives, often have sacred protection, always escape from serious accidents, are involved with sacred things, have financial fortune, make firm decisions, excellent concentration, have prosperity, and in life will achieve great success.
            """,
            91: """
            People under this number's influence often interested in research, devoted to mystical sciences, have unique innovative thoughts, like keeping to themselves, often isolate themselves in solitude, but have ambition, seek progress in life, have high determination and intention, are people who always like to seek new things in life.
            """,
            92: """
            A good number. These people have mysterious charm, life likes traveling, like strange new things, interested in mystical sciences, interested in history, often have intuition, like antiques, like to seriously study ancient traditions and customs, like poetry, and often soft-hearted, trust people easily.
            """,
            93: """
            People under this number's influence are often strong, brave-hearted, quick to decide, self-willed, rash, would rather break than bend, thus not having many supporters. Like violence but are interested in religion, mystical things. Life often experiences success, advance in work duties, can build themselves up by themselves. Often get strange diseases, beware of surgery.
            """,
            94: """
            People under this number's influence often like to talk and negotiate, easily get along with others, good at adapting, suitable for work related to international contact, marketing, tourism. Have excellent intelligence, have intuition, have sacred protection, interested in mystical sciences, psychology, but beware of accidents and unexpected turning points in life.
            """,
            95: """
            A good number indicating success. People under this number's influence often have special intuition, have sacred protection, have virtue, love justice, don't like taking advantage of others, have academic knowledge, get along well with seniors, have people helping and supporting, interested in religion, like to study astrology and spirituality, get along well with seniors, life will achieve success and have good opportunities abroad.
            """,
            96: """
            People under this number's influence are often soft-hearted, thus easily led astray, not very self-confident, do things halfway, lack patience. If associating with good people will be good, but if associating with bad people will follow their bad ways. But on the good side often have intuition, have sacred protection, kind-hearted, will have luck abroad.
            """,
            97: """
            People under this number's influence, before achieving success in life must overcome numerous obstacles. Life exhausting since childhood, difficult for others to persuade or influence. Work duties often progress well, have strong endurance in work duties, are bosses that subordinates respect. But in life often have mental pressure, making them always anxious, overthinking. Beware of hard-to-cure diseases and should be careful of dangers from accidents, might be harmed from past karma.
            """,
            98: """
            Another number giving benefits in dramatic ways. People under its influence will achieve success related to vice businesses, like associating with gangsters, have many followers, like doing strange innovative things, easily get along with anyone. Often interested in sacred things until obsessed, without using intelligence to consider, thus becoming misguided. Must beware not to associate with bad people, if getting involved will be hard to withdraw from bad things.
            """,
            99: """
            People of this number can sense things that ordinary humans cannot know, have excellent intuition or special insight, have high psychic power, interested in religion, philosophy, ancient things, general mysteries. Have strong mental power, will achieve unexpected success, often lucky in financial matters.
            """,
            100: """
            Considered a number of completeness, facilitating full life success. A number that bestows fortune to achieve beautiful success, have honor, have dignity respected by people in general. Indicates progress without stopping, like researching new things, will be fulfilled in love matters, get good partners, succeed well in financial matters, have good luck in financial matters.
            """,
        ]
    
    
    func calculateScore(for name: String) -> Int {
        let upperName = name.uppercased()
        return upperName.reduce(0) { sum, char in
            sum + (characterScores[char] ?? 0)
        }
    }
    
    func getDestinyDescription(for score: Int) -> String {
        return destinyDescriptions[score] ?? "Your destiny is yet to be written..."
    }
    
    func calculateDestiny() {
        isLoading = true
        
        // Simulate API call or complex calculation with delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [weak self] in
            guard let self = self else { return }
            
            self.firstNameScore = self.calculateScore(for: self.firstName)
            self.lastNameScore = self.calculateScore(for: self.lastName)
            self.totalScore = self.firstNameScore + self.lastNameScore
            
            self.isLoading = false
            self.showResult = true
        }
    }
}
