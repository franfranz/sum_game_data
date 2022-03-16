## Training_testing_inputs

This folder contains the traning and the testing sets used in the tryout of sum_game with integers from 0 to 5. In

* S0, the training and the testing set contain the same couples 
* S2, each sum is represented by different couples, (e.g. 0;2 in training, 1;1 in testing)
* S3, each sum is represented by the same couples in different orders (e.g. 2;3 in training, 3;2 in testing)
* S4, the test set comprises sums from 1 to 6; the first integer ranges 0 to 5 and the second from 0 to 2.  


These sets were run with this configuration: 

```bash
python -m play_sum_v05_03 --mode 'gs' --train_data "fullset_train_n5.txt" --validation_data "train_test_set_n5_S0.txt" --n_attributes 2 --n_values 7 --n_epochs 120 --batch_size 512 --validation_batch_size 1000 --max_len 1 --vocab_size 500 --sender_hidden 256 --receiver_hidden 512 --sender_embedding 5 --receiver_embedding 30 --receiver_cell "gru" --sender_cell "gru" --lr 0.01 --random_seed 1 --temperature 3 --print_validation_events
```
