destinations = [
	"HAVANA,",
	"MATANZAS,",
	"VARADERO,MATANZAS",
	"CIEGO DE AVILA,",
	"CAYO GUILLERMO,CIEGO DE AVILA",
	"OLD HAVANA,HAVANA",
	"VILLA CLARA,",
	"SANTA CLARA CITY,VILLA CLARA",
	"EASTERN BEACHES,HAVANA",
	"GRANMA,",
	"SANTIAGO DE CUBA,",
	"REMEDIOS,VILLA CLARA",
	"CIENAGA DE ZAPATA,MATANZAS",
	"HOLGUIN,",
	"PLAYA PESQUERO,HOLGUIN",
	"CAYO COCO,CIEGO DE AVILA",
	"MAYABEQUE,",
	"JIBACOA,MAYABEQUE",
	"LAS TUNAS,",
	"COVARRUBIAS,LAS TUNAS",
	"GUARDALAVACA,HOLGUIN",
	"CAMAGUEY,",
	"SANTA LUCIA,CAMAGUEY",
	"PLAYA CHIVIRICO,SANTIAGO DE CUBA",
	"SANCTI SPIRITUS,",
	"TRINIDAD,SANCTI SPIRITUS",
	"LAS TUNAS CITY,LAS TUNAS",
	"GUANTANAMO,",
	"CAIMANERA,GUANTANAMO",
	"CAMAGUEY CITY,CAMAGUEY",
	"MATANZAS CITY,MATANZAS",
	"VEDADO,HAVANA",
	"SANTIAGO DE CUBA CITY,SANTIAGO DE CUBA",
	"CIENFUEGOS,",
	"PINAR DEL RIO,",
	"CAYO LEVISA,PINAR DEL RIO",
	"MIRAMAR,HAVANA",
	"ISLA DE LA JUVENTUD,",
	"CIEGO DE AVILA CITY,CIEGO DE AVILA",
	"PARQUE BACONAO,SANTIAGO DE CUBA",
	"MAREA DEL PORTILLO,GRANMA",
	"HOLGUIN CITY,HOLGUIN",
	"BARACOA,GUANTANAMO",
	"CORRALILLO,VILLA CLARA",
	"CAYO SANTA MARIA,VILLA CLARA",
	"FLORIDA TOWN,CAMAGUEY",
	"MANZANILLO,GRANMA",
	"GUANTANAMO CITY,GUANTANAMO",
	"HANABANILLA,VILLA CLARA",
	"SANCTI SPIRITUS CITY,SANCTI SPIRITUS",
	"CAYO ENSENACHOS,VILLA CLARA",
	"CAYO LARGO,ISLA DE LA JUVENTUD",
	"TOPES DE COLLANTES,SANCTI SPIRITUS",
	"VINALES,PINAR DEL RIO",
	"JARDINES DE LA REINA,CIEGO DE AVILA",
	"GUANAHACABIBES,PINAR DEL RIO",
	"SAN DIEGO,PINAR DEL RIO",
	"ARTEMISA,",
	"LAS TERRAZAS,ARTEMISA",
	"CITY OF MORON,CIEGO DE AVILA",
	"GIBARA,HOLGUIN",
	"PINAR DEL RIO CITY,PINAR DEL RIO",
	"BAYAMO CITY,GRANMA",
	"CAYO SAETIA,HOLGUIN",
	"SIERRA MAESTRA,SANTIAGO DE CUBA",
	"CAYO LAS BRUJAS,VILLA CLARA",
	"PINARES DE MAYARI,HOLGUIN",
	"YAGUAJAY,SANCTI SPIRITUS",
	"SOROA,ARTEMISA",
	"PLAYA LARGA,MATANZAS",
	"PLAYA GIRON,MATANZAS"
]

def create_taxonomy
	puts "creating taxonomy: destinations"
	taxonomy = Spree::Taxonomy.where(:name => 'destinations').first_or_create
end

def create_taxon(taxon_name, parent_taxon, taxonomy)
	parent_taxon = Spree::Taxon.where(:name => parent_taxon.name, :taxonomy => taxonomy).first_or_create if parent_taxon
	puts "creating taxon: #{taxon_name} => #{parent_taxon.name rescue nil}"
	taxon = Spree::Taxon.where(:name => taxon_name, :parent => parent_taxon, :taxonomy => taxonomy).first_or_create
end

def create_all_taxons(list, taxonomy)
	list.each do |string|
		child, parent = string.split(',')
		parent_taxon = create_taxon(parent, nil, taxonomy) if parent
		child_taxon = create_taxon(child, parent_taxon, taxonomy)
	end
end

taxonomy = create_taxonomy
create_all_taxons(destinations, taxonomy)
