// Serveur CampusFlow : json-server + une fausse authentification par jeton.
//
//   POST /login  { "email": "...", "motDePasse": "..." }  →  { "jeton": "...", "utilisateur": {...} }
//   Toutes les autres adresses exigent l'en-tête  Authorization: Bearer <jeton>
//   sinon le serveur répond 401 (non authentifié).
//
// Les jetons sont gardés en mémoire : redémarrer le serveur les invalide tous,
// ce qui permet de tester la redirection vers l'écran de connexion (401).

const crypto = require('crypto');
const jsonServer = require('json-server');

const PORT = 3000;
const DUREE_JETON_MS = 30 * 60 * 1000; // 30 minutes

const server = jsonServer.create();
const router = jsonServer.router('db.json');
const jetons = new Map(); // jeton -> { idUtilisateur, expire }

server.use(jsonServer.defaults()); // CORS, journal des requêtes
server.use(jsonServer.bodyParser);

// 1. Connexion : vérifie l'identifiant et le mot de passe, renvoie un jeton.
server.post('/login', (req, res) => {
  const { email, motDePasse } = req.body || {};
  const utilisateur = router.db.get('utilisateurs').find({ email }).value();
  if (!utilisateur || utilisateur.motDePasse !== motDePasse) {
    return res.status(401).json({ message: 'Identifiants incorrects' });
  }
  const jeton = crypto.randomBytes(24).toString('hex');
  jetons.set(jeton, { idUtilisateur: utilisateur.id, expire: Date.now() + DUREE_JETON_MS });
  const { motDePasse: _cache, ...profil } = utilisateur;
  res.json({ jeton, utilisateur: profil });
});

// 2. Garde : toute autre requête doit porter un jeton valide.
server.use((req, res, next) => {
  const entete = req.headers.authorization || '';
  const jeton = entete.startsWith('Bearer ') ? entete.slice(7) : null;
  const session = jeton ? jetons.get(jeton) : undefined;
  if (!session || session.expire < Date.now()) {
    if (jeton) jetons.delete(jeton);
    return res.status(401).json({ message: 'Non authentifié : jeton absent ou expiré' });
  }
  next();
});

// 3. Les mots de passe ne sortent jamais du serveur.
router.render = (req, res) => {
  const sansMotDePasse = (o) => {
    if (o && typeof o === 'object' && 'motDePasse' in o) {
      const { motDePasse: _cache, ...reste } = o;
      return reste;
    }
    return o;
  };
  const donnees = res.locals.data;
  res.jsonp(Array.isArray(donnees) ? donnees.map(sansMotDePasse) : sansMotDePasse(donnees));
};

server.use(router);

server.listen(PORT, () => {
  console.log(`API CampusFlow : http://localhost:${PORT}`);
  console.log('Compte de démonstration : etudiant@campusflow.bf / campus2026');
});
