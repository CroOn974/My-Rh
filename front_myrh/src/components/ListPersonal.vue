<template>
  <div>
    <v-alert v-if="showMessage" closable type="success">
      {{ message }}
    </v-alert>
    <v-card>
      <v-card-title>
        <v-text-field
          v-model="search"
          label="Rechercher"
          prepend-icon="mdi-magnify"
          class="ml-4"
        ></v-text-field>
      </v-card-title>
      <v-card-text>
        <v-data-table
          v-model:items-per-page="itemsPerPage"
          :headers="headers"
          :items="personals"
          item-key="id_personal"
          class="elevation-1"
          :search="search"
          :loading="loading"
          
        >
          <template v-slot:item="{ item }">
            <tr>
              <td>{{ item.columns.id_personal }}</td>
              <td>{{ item.columns.first_name }}</td>
              <td>{{ item.columns.last_name }}</td>
              <td>{{ item.columns.phone_number }}</td>
              <td>{{ item.columns.email }}</td>
              <td>{{ item.columns.email_personnal }}</td>
              <td>{{ item.columns.gender_label }}</td>
              <!-- Bouton de suppression -->
              <td>
                <v-btn @click="showUpdateModal(item)" color="blue">Modifier</v-btn>
                <v-btn @click="showConfirmationDialog(item.columns.id_personal)" color="red">Supprimer</v-btn>
              </td>
            </tr>
          </template>
        </v-data-table>
      </v-card-text>
    </v-card>
      <v-btn @click="showCreateModal" color="primary">Ajouter une personne</v-btn>

      <v-dialog v-model="createModalVisible" max-width="500px">
        <v-card>
          <v-card-title>
            <h2>Ajouter une personne</h2>
          </v-card-title>
          <v-card-text>
            <v-form @submit.prevent="createPerson">
              <v-text-field v-model="newPerson.first_name" label="Prénom" :rules="[nameRule]"></v-text-field>
              <v-text-field v-model="newPerson.last_name" label="Nom" :rules="[nameRule]"></v-text-field>
              <v-text-field v-model="newPerson.phone_number" label="Numéro de téléphone" :rules="[numberRule]"></v-text-field>
              <v-text-field v-model="newPerson.email" label="Email" :rules="[emailRules]"></v-text-field>
              <v-text-field v-model="newPerson.email_personnal" label="Email personnel" :rules="[emailRules]"></v-text-field>
              <v-select
                v-model="newPerson.id_gender"
                :hint="`${genders.id_gender}, ${genders.label}`"
                :items="genders"
                item-title="label"
                item-value="id_gender"
                label="Genre"
                
              ></v-select>
              <v-btn type="submit" color="primary">Ajouter</v-btn>
            </v-form>
          </v-card-text>
        </v-card>
      </v-dialog>


      <v-dialog v-model="confirmationDialogVisible" max-width="500px">
        <v-card>
          <v-card-title>
            <h2>Confirmation de suppression</h2>
          </v-card-title>
          <v-card-text>
            Êtes-vous sûr de vouloir supprimer cette personne ?
          </v-card-text>
          <v-card-actions>
            <v-btn @click="deletePerson" color="red">Oui, supprimer</v-btn>
            <v-btn @click="cancelDelete" color="grey">Annuler</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
  </div>

  <v-dialog v-model="updateModalVisible" max-width="500px">
    <v-card>
      <v-card-title>
        <h2>Modifier une personne</h2>
      </v-card-title>
      <v-card-text>
        <v-form @submit.prevent="updatePerson">
          <v-text-field v-model="upPerson.first_name" label="Prénom" :rules="[nameRule]"></v-text-field>
          <v-text-field v-model="upPerson.last_name" label="Nom" :rules="[nameRule]"></v-text-field>
          <v-text-field v-model="upPerson.phone_number" label="Numéro de téléphone" :rules="[numberRule]"></v-text-field>
          <v-text-field v-model="upPerson.email" label="Email" :rules="[emailRules]"></v-text-field>
          <v-text-field v-model="upPerson.email_personnal" label="Email personnel" :rules="[emailRules]"></v-text-field>
          <v-select
            v-model="genderselect"
            :hint="`${genders.gender_id}, ${genders.label}`"
            :items="genders"
            item-title="label" 
            item-value="id_gender"
            label="Genre"
          ></v-select>
          <v-btn type="submit" color="primary">Modifier</v-btn>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>

</template>
  
  <script>
  import axios from 'axios';
  import { VDataTable } from 'vuetify/lib/labs/VDataTable'
  import { VDialog, VCard, VCardTitle, VCardText, VForm, VTextField, VSelect, VBtn } from 'vuetify/lib/components';

export default {
  components: {
    VDataTable,
    VDialog,
    VCard,
    VCardTitle,
    VCardText,
    VForm,
    VTextField,
    VSelect,
    VBtn
  },
    
    data() {
      return {
        headers: [
        {
          title: 'ID',
          align: 'middle',
          sortable: false,
          key: 'id_personal',
        },
        { title: 'Prénom', align: 'middle', key: 'first_name' },
        { title: 'Nom', align: 'middle', key: 'last_name' },
        { title: 'Numéro de téléphone', align: 'middle', key: 'phone_number' },
        { title: 'Email', align: 'middle', key: 'email' },
        { title: 'Email personnel', align: 'middle', key: 'email_personnal' },
        { title: 'Id Genre', align: 'middle', key: 'id_gender' },
        { title: 'Genre', align: 'middle', key: 'gender_label' },
        ],
        personals: [],
        genders:[],
        search: '',
        loading: false,
        totalItems: 0,
        itemsPerPage: 10,
        newPerson: {
          first_name: '',
          last_name: '',
          phone_number: '',
          email: '',
          email_personnal: '',
          id_gender: '',
        },
        upPerson: {
          first_name: '',
          last_name: '',
          phone_number: '',
          email: '',
          email_personnal: '',
          id_gender: '',
        },
        genderselect: {
          id_gender: '',
          gender_label: '',
        },
        createModalVisible: false,
        confirmationDialogVisible: false,
        updateModalVisible: false,
        personIdToDelete: '',
        showMessage: false,
        message: '',
        // Rules
        emailRules: value => {
          if(value.length > 0) {
          const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || 'Invalid e-mail.';
          }
        },
        numberRule: v  => {
          if (!v.trim()) return true;
          if (!isNaN(parseFloat(v)) && v >= 0 && v <= 99999999999999) return true;
          if (!v.length == 15) return true
          return 'Numero de téléphone doit contenir 8 numero';
        },
        nameRule: value => {
          if (value.length > 0) {
            const pattern = /^[A-Za-z]{2,20}$/; // Utilisez des délimiteurs de début et de fin pour le motif regex
            return pattern.test(value) || 'le nom et le prénom doit contenir en 2 a 20 lettres';
          }
        }
      };
    },
    mounted() {
      this.fetchPersonals();
      this.fetchGender();
    },
    methods: {
      /**
       *  Récupère la liste du personel
       * 
       */
      fetchPersonals() {
        this.loading = true;
        axios
          .get('api/personal/') // Remplacez l'URL par votre endpoint de l'API
          .then((response) => {
            this.personals = response.data;
            this.totalItems = response.data.length;
            console.log(this.personals);
          })
          .catch((error) => {
            console.error(error);
          })
          .finally(() => {
            this.loading = false;
          });
      },
      /**
       *  Récupère les list des genre
       * 
       */
      fetchGender(){
        axios
          .get('api/gender/')
          .then((response) => {
            this.genders = response.data;
            console.log(this.genders);
          })
          .catch((error) => {
            console.error(error);
          })

      },
      showCreateModal() {
        this.createModalVisible = true;
      },
      createPerson() {
        // Logique d'ajout de personne
        console.log('Création de personne :', this.newPerson);

        // Envoyer la requête POST pour ajouter la personne
        axios
          .post('api/personal/', this.newPerson)
          .then((response) => {
            console.log('Personne ajoutée avec succès:', response.data);

            this.message = 'la personne ' + this.newPerson.first_name + ' ' + this.newPerson.last_name + ' a était crée.'
            this.showMessage = true

            // Réinitialiser le formulaire et fermer le modal
            this.newPerson = {
              first_name: '',
              last_name: '',
              phone_number: '',
              email: '',
              email_personnal: '',
              gender_id: '',
              gender_label: '',
            };
            this.createModalVisible = false;

            // Mettre à jour la liste des personnels pour afficher la nouvelle personne ajoutée
            this.fetchPersonals();
            
          })
          .catch((error) => {
            console.error('Erreur lors de l\'ajout de personne:', error);
          });
      },
      showConfirmationDialog(personId) {
        // Afficher la boîte de dialogue de confirmation et stocker l'ID de la personne à supprimer
        this.confirmationDialogVisible = true;
        this.personIdToDelete = personId;
      },
      deletePerson() {
        // Effectuer la suppression de la personne via l'API
        axios.delete(`api/personal/${this.personIdToDelete}/`)
          .then(response => {
            // // Supprimer l'entrée de la personne de la liste
            this.personals = this.personals.filter(person => person.id_personal !== this.personIdToDelete);
            console.log(response);
            // // Réinitialiser les variables
            this.confirmationDialogVisible = false;
            this.personIdToDelete = null;

            this.message = 'Personne supprimer'
            this.showMessage = true
          })
          .catch(error => {
            console.error(error);
          });
      },
      cancelDelete() {
        // Annuler la suppression de la personne
        this.confirmationDialogVisible = false;
        this.personIdToDelete = null;
      },

    showUpdateModal(person) {
      console.log(person);
      this.upPerson = {
        id_personal: person.columns.id_personal,
        first_name: person.columns.first_name,
        last_name: person.columns.last_name,
        phone_number: person.columns.phone_number,
        email: person.columns.email,
        email_personnal: person.columns.email_personnal,
        id_gender: person.columns.id_gender,
        gender_label: person.columns.gender_label,
      };
      this.genderselect = {
        id_gender: person.columns.id_gender,
        gender_label: person.columns.gender_label,
      };
      this.updateModalVisible = true;

    },

    updatePerson() {
      axios
        .put(`api/personal/${this.upPerson.id_personal}/`, this.upPerson)
        .then((response) => {
          console.log('Personne modifier avec succès:', response.data);

          this.message = 'Personne modifier avec succès'
          this.showMessage = true

          // Réinitialiser le formulaire et fermer le modal
          this.upPerson = {
            id_personal: '',
            first_name: '',
            last_name: '',
            phone_number: '',
            email: '',
            email_personnal: '',
            gender_id: '',
            gender_label: '',
          };
          this.updateModalVisible = false;

          // Mettre à jour la liste des personnels pour afficher la personne mise à jour
          this.fetchPersonals();
        })
        .catch((error) => {
          console.error('Erreur lors de la mise à jour de la personne:', error);
        });
    },
    },
  };
  </script>