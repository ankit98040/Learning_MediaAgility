from google.cloud import storage
import os
    
#os.environ["GOOGLE_APPLICATION_CREDENTIALS"]="/home/ankit_pramanik/cloudshell_open/Google_storage_testing/all-pacific-f4a2fbe1cef1.json"

def mv_blob(bucket_name, blob_name, new_bucket_name, new_blob_name):
    """
    Function for moving files between directories or buckets. it will use GCP's copy 
    function then delete the blob from the old location.
    
    inputs
    -----
    bucket_name: 'test_nm'
    blob_name: 'cert3.pdf'
    new_bucket_name: 'dataflow_bucket12'
    new_blob_name: 'cert1.pdf' 
       
    """
    storage_client = storage.Client()
    source_bucket = storage_client.get_bucket(bucket_name)
    source_blob = source_bucket.blob(blob_name)
    destination_bucket = storage_client.get_bucket(new_bucket_name)

    # copy to new destination
    new_blob = source_bucket.copy_blob(
        source_blob, destination_bucket, new_blob_name)
    # delete in old destination
    source_blob.delete()
    
    print('File moved from old bucket to new bucket')

mv_blob('test_nm', 'cert3.pdf', 'dataflow_bucket12', 'cert2.pdf')
