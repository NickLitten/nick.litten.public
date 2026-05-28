-- ============================================================================
-- Script Name: SIMPLEFILE-Super_Simple_file_with_NAME_ADDRESS.sql
-- Description: Populate SIMPLEFILE with 100 celebrity and well-known people
-- Author: Nick Litten
-- Created: 2026-05-17
-- ============================================================================
-- Purpose:
--   - Insert 100 rows of sample data into SIMPLEFILE
--   - Uses names of celebrities and well-known historical figures
--   - Provides realistic address data for testing
-- ============================================================================
set schema NICKLITTEN;

create or replace table SIMPLEFILE (
      NAME char(50) not null,
      ADDRESS char(500) not null
    )
  rcdfmt RSIMPLE;

label on table SIMPLEFILE is 'Simple file with name and address';

label on column SIMPLEFILE (
  NAME is 'THIS IS THE NAME',
  ADDRESS is 'THIS IS THE ADDRESS'
);


-- Clear existing data
delete from SIMPLEFILE;

-- Insert 100 celebrity records
insert into SIMPLEFILE (
      NAME,
      ADDRESS
    )
  values
    (
      'Einstein',
      '112 Mercer St, Princeton NJ 08540'
    ),
    (
      'Mozart',
      'Domgasse 5, 1010 Vienna Austria'
    ),
    (
      'Shakespeare',
      'Henley St, Stratford-upon-Avon CV37 6QW UK'
    ),
    (
      'Da Vinci',
      'Via della Ninna 5, 50122 Florence Italy'
    ),
    (
      'Curie',
      '1 Rue Pierre et Marie Curie, 75005 Paris France'
    ),
    (
      'Tesla',
      '8 West 40th St, New York NY 10018'
    ),
    (
      'Newton',
      'Woolsthorpe Manor, Grantham NG33 5NR UK'
    ),
    (
      'Galileo',
      'Via del Proconsolo 12, 50122 Florence Italy'
    ),
    (
      'Darwin',
      'Down House, Luxted Rd, Downe BR6 7JT UK'
    ),
    (
      'Hawking',
      'Gonville and Caius College, Cambridge CB2 1TA'
    ),
    (
      'Turing',
      'Wilmslow Rd, Manchester M13 9PL UK'
    ),
    (
      'Jobs',
      '1 Infinite Loop, Cupertino CA 95014'
    ),
    (
      'Gates',
      '1835 73rd Ave NE, Medina WA 98039'
    ),
    (
      'Musk',
      '3500 Deer Creek Rd, Palo Alto CA 94304'
    ),
    (
      'Bezos',
      '410 Terry Ave N, Seattle WA 98109'
    ),
    (
      'Zuckerberg',
      '1 Hacker Way, Menlo Park CA 94025'
    ),
    (
      'Wozniak',
      '2066 Crist Dr, Los Altos CA 94024'
    ),
    (
      'Torvalds',
      'Dunthorpe, Portland OR 97219'
    ),
    (
      'Berners-Lee',
      'MIT CSAIL, 32 Vassar St, Cambridge MA 02139'
    ),
    (
      'Knuth',
      '450 Serra Mall, Stanford CA 94305'
    ),
    (
      'Dijkstra',
      'Plataanstraat 5, 5671 AL Nuenen Netherlands'
    ),
    (
      'Hopper',
      'Yale University, New Haven CT 06520'
    ),
    (
      'Lovelace',
      '6 St James Square, London SW1Y 4JU UK'
    ),
    (
      'Babbage',
      '1 Dorset St, London W1U 4EG UK'
    ),
    (
      'Boole',
      'University College Cork, Cork Ireland'
    ),
    (
      'Mandela',
      '8115 Vilakazi St, Orlando West, Soweto 1804'
    ),
    (
      'Gandhi',
      'Sabarmati Ashram, Ahmedabad 380027 India'
    ),
    (
      'King Jr',
      '501 Auburn Ave NE, Atlanta GA 30312'
    ),
    (
      'Churchill',
      '10 Downing St, Westminster, London SW1A 2AA'
    ),
    (
      'Roosevelt',
      '4097 Albany Post Rd, Hyde Park NY 12538'
    ),
    (
      'Lincoln',
      '1600 Pennsylvania Ave NW, Washington DC 20500'
    ),
    (
      'Washington',
      'Mount Vernon, 3200 Mount Vernon Hwy VA 22121'
    ),
    (
      'Jefferson',
      'Monticello, 931 Thomas Jefferson Pkwy VA 22902'
    ),
    (
      'Franklin',
      '317 Chestnut St, Philadelphia PA 19106'
    ),
    (
      'Cleopatra',
      'Alexandria Palace, Alexandria Egypt'
    ),
    (
      'Caesar',
      'Via dei Fori Imperiali, 00186 Rome Italy'
    ),
    (
      'Napoleon',
      'Château de Malmaison, 92500 Rueil France'
    ),
    (
      'Columbus',
      'Calle Colon 1, 41001 Seville Spain'
    ),
    (
      'Magellan',
      'Rua de Sabrosa, 5060-284 Sabrosa Portugal'
    ),
    (
      'Armstrong',
      '8001 Gemini Ave, Houston TX 77058'
    ),
    (
      'Aldrin',
      '2101 NASA Pkwy, Houston TX 77058'
    ),
    (
      'Gagarin',
      'Star City, Moscow Oblast 141160 Russia'
    ),
    (
      'Wright',
      '1127 West Third St, Dayton OH 45402'
    ),
    (
      'Edison',
      '2350 Lakeside Ave, Orange NJ 07050'
    ),
    (
      'Bell',
      '537 Washington St, Boston MA 02111'
    ),
    (
      'Ford',
      '20900 Oakwood Blvd, Dearborn MI 48124'
    ),
    (
      'Disney',
      '500 S Buena Vista St, Burbank CA 91521'
    ),
    (
      'Chaplin',
      '1416 N La Brea Ave, Los Angeles CA 90028'
    ),
    (
      'Hitchcock',
      'Universal Studios, 100 Universal City CA 91608'
    ),
    (
      'Spielberg',
      'Amblin Entertainment, Universal City CA 91608'
    ),
    (
      'Lucas',
      'Skywalker Ranch, 5858 Lucas Valley Rd CA 94903'
    ),
    (
      'Kubrick',
      'Childwickbury Manor, St Albans AL3 6JJ UK'
    ),
    (
      'Tarantino',
      '5555 Melrose Ave, Los Angeles CA 90038'
    ),
    (
      'Scorsese',
      '445 Park Ave, New York NY 10022'
    ),
    (
      'Coppola',
      'Inglenook Winery, 1991 St Helena Hwy CA 94574'
    ),
    (
      'Eastwood',
      'Malpaso Productions, Burbank CA 91505'
    ),
    (
      'Streep',
      '888 Seventh Ave, New York NY 10019'
    ),
    (
      'Hanks',
      '10202 W Washington Blvd, Culver City CA 90232'
    ),
    (
      'DiCaprio',
      '9465 Wilshire Blvd, Beverly Hills CA 90212'
    ),
    (
      'Pitt',
      '9465 Wilshire Blvd, Beverly Hills CA 90212'
    ),
    (
      'Jolie',
      '9465 Wilshire Blvd, Beverly Hills CA 90212'
    ),
    (
      'Winfrey',
      '1058 W Washington Blvd, Chicago IL 60607'
    ),
    (
      'Beyonce',
      '1100 Glendon Ave, Los Angeles CA 90024'
    ),
    (
      'Swift',
      '242 West Main St, Hendersonville TN 37075'
    ),
    (
      'Beatles',
      '3 Savile Row, London W1S 3PB UK'
    ),
    (
      'Presley',
      '3734 Elvis Presley Blvd, Memphis TN 38116'
    ),
    (
      'Jackson',
      '2300 Jackson St, Gary IN 46407'
    ),
    (
      'Madonna',
      '75 Rockefeller Plaza, New York NY 10019'
    ),
    (
      'Bowie',
      '42 Stansfield Rd, Brixton, London SW9 9RZ UK'
    ),
    (
      'Mercury',
      '22 Gladstone Ave, Feltham TW14 9LL UK'
    ),
    (
      'Hendrix',
      '23 Brook St, Mayfair, London W1K 4HA UK'
    ),
    (
      'Cobain',
      '171 Lake Washington Blvd E, Seattle WA 98112'
    ),
    (
      'Lennon',
      '1 W 72nd St, New York NY 10023'
    ),
    (
      'Marley',
      '56 Hope Rd, Kingston 6 Jamaica'
    ),
    (
      'Sinatra',
      '915 N Beverly Dr, Beverly Hills CA 90210'
    ),
    (
      'Armstrong',
      '3456 Queens Blvd, Long Island City NY 11101'
    ),
    (
      'Fitzgerald',
      '1217 Kearny St, Berkeley CA 94706'
    ),
    (
      'Holiday',
      '2600 Lafayette Ave, Baltimore MD 21216'
    ),
    (
      'Picasso',
      'Museu Picasso, Montcada 15-23, Barcelona Spain'
    ),
    (
      'Van Gogh',
      'Museumplein 6, 1071 DJ Amsterdam Netherlands'
    ),
    (
      'Monet',
      '84 Rue Claude Monet, 27620 Giverny France'
    ),
    (
      'Rembrandt',
      'Jodenbreestraat 4, 1011 NK Amsterdam Netherlands'
    ),
    (
      'Michelangelo',
      'Piazza del Duomo, 50122 Florence Italy'
    ),
    (
      'Warhol',
      '117 Sandusky St, Pittsburgh PA 15212'
    ),
    (
      'Dali',
      'Pujada del Castell 28, 17600 Figueres Spain'
    ),
    (
      'Kahlo',
      'Londres 247, Del Carmen, Coyoacan Mexico'
    ),
    (
      'Banksy',
      'Stokes Croft, Bristol BS2 8QR UK'
    ),
    (
      'Hemingway',
      '907 Whitehead St, Key West FL 33040'
    ),
    (
      'Tolkien',
      '20 Northmoor Rd, Oxford OX2 6UR UK'
    ),
    (
      'Rowling',
      '78 Cramond Glebe Rd, Edinburgh EH4 6NS UK'
    ),
    (
      'Austen',
      'Chawton Cottage, Chawton, Alton GU34 1SD UK'
    ),
    (
      'Dickens',
      '48 Doughty St, London WC1N 2LX UK'
    ),
    (
      'Twain',
      '351 Farmington Ave, Hartford CT 06105'
    ),
    (
      'Poe',
      '203 N Amity St, Baltimore MD 21223'
    ),
    (
      'Wilde',
      '34 Tite St, Chelsea, London SW3 4JA UK'
    ),
    (
      'Orwell',
      '27B Canonbury Square, London N1 2AN UK'
    ),
    (
      'Kafka',
      'Zlatá ulička 22, 119 00 Prague Czech Republic'
    ),
    (
      'Dostoevsky',
      'Kuznechny Pereulok 5, St Petersburg Russia'
    ),
    (
      'Tolstoy',
      'Yasnaya Polyana, Tula Oblast 301214 Russia'
    );


commit;


-- Verify record count
select count(*) as RECORD_COUNT
  from SIMPLEFILE;


-- Display first 10 records
select *
  from SIMPLEFILE
  fetch first 10 rows only;