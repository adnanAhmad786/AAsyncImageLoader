
import UIKit
import AAsyncImageLoader

class ViewController: UIViewController {

    let data = [
        "Philippe Conticini": "https://www.academiedugout.fr/images/130/138-138/philippe-conticini_retouche_01.jpg",
        "Pierre Hermé": "https://www.academiedugout.fr/images/128/138-138/pierre-herme_retouche_01.jpg",
        "Thierry Marx": "https://www.academiedugout.fr/images/122/138-138/thierry-marx_retouche_01.jpg",
        "Joël Robuchon": "https://www.academiedugout.fr/images/127/138-138/joel-robuchon_retouche_01.jpg",
        "Frédéric Vardon": "https://www.academiedugout.fr/images/9572/138-138/nouvelle-photo-f-vardon-carree.jpg",
        "Guy Martin": "https://www.academiedugout.fr/images/30781/138-138/guy-martin-3.jpg",
        "Hamid Miss": "https://www.academiedugout.fr/images/45593/138-138/hd_gerant_2ok.jpg",
        "Alain Ducasse": "https://www.academiedugout.fr/images/121/138-138/alain_ducasse_retouche_01.png",
        "Anne-Sophie Pic": "https://www.academiedugout.fr/images/9659/138-138/anne-sophie-pic_retouche_01.jpg",
        "Emmanuel Renaut": "https://www.academiedugout.fr/images/9661/138-138/emmanuel_renaut_retouche_01.jpg",
        "Régis et Jacques Marcon": "https://www.academiedugout.fr/images/29035/138-138/c.rina_nurra.jpg",
        "Sophie Dudemaine": "https://www.academiedugout.fr/images/23171/138-138/sophie-dudemaine.jpg",
        "Hugues Pouget": "https://www.academiedugout.fr/images/29759/138-138/photo-hugues.jpg",
        "Massimiliano Alajmo": "https://www.academiedugout.fr/images/31665/138-138/massimiliano-alajmo.jpg",
        "Arnaud Lallement": "https://www.academiedugout.fr/images/21525/138-138/arnaud-lallementok.jpg",
        "Christian Le Squer": "https://www.academiedugout.fr/images/29743/138-138/gilles-dacquin-6836.jpg",
        "Bruno Oger": "https://www.academiedugout.fr/images/23015/138-138/bruno-oger-ok.jpg",
        "Paul Bocuse": "https://www.academiedugout.fr/images/126/138-138/paul-bocuse_retouche_01.jpg",
        "Cyril Lignac": "https://www.academiedugout.fr/images/123/138-138/cyril_lignac_portrait2.jpg",
        "Florent Ladeyn": "https://www.academiedugout.fr/images/20793/138-138/florent-ladeyn-retaille.png",
        "Guy Savoy": "https://www.academiedugout.fr/images/9658/138-138/guy-savoy_retouche_01.jpg",
        "Sébastien Bouillet": "https://www.academiedugout.fr/images/31031/138-138/sb.jpg",
        "Georges Blanc": "https://www.academiedugout.fr/images/29859/138-138/portrait-georges-blanc.jpg",
        "Alain Dutournier": "https://www.academiedugout.fr/images/29731/138-138/dutournier.jpg",
        "Christophe Adam": "https://www.academiedugout.fr/images/23259/138-138/chistophe-adam-ok.jpg",
        "Akrame Benallal": "https://www.academiedugout.fr/images/20705/138-138/photo-de-profil.jpg",
        "Mauro Colagreco": "https://www.academiedugout.fr/images/30807/138-138/mauro-colagreco-by-per-anders-jorgensen.jpg",
        "Claire Heitzler": "https://www.academiedugout.fr/images/2733/138-138/claire-heitzler_retouche_01.jpg",
        "Thibault Sombardier": "https://www.academiedugout.fr/images/31203/138-138/thibault-sombardier.jpg",
        "Christophe Michalak": "https://www.academiedugout.fr/images/9660/138-138/christophe-michalak_retouche_01.jpg"
    ]

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate {

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Touched cell")
    }
}

extension ViewController: UITableViewDataSource {

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        
        let name = Array<String>(data.keys)[indexPath.row]
        let imageUrl = data[name]!

        cell.textLabel?.text = name
        cell.imageView?.aail_load(url: URL(string: imageUrl)!, placeholder: UIImage(named: "placeholder_image"))
        
        return cell
    }
}
